const db = require('../config/db')
const bcrypt = require('bcrypt')

exports.loginForm = (req, res) => {
  res.render('auth/login')
}

exports.login = async (req, res) => {
  const { email, password } = req.body
  if (!email || !password) {
    req.flash('errores', 'Todos los campos son necesarios')
    return res.redirect('/login')
  }
  const emailRegex = /\S+@\S+\.\S+/
  if (!emailRegex.test(email)) {
    req.flash('errores', 'Ingrese una direccion de correo valida')
    return res.redirect('/login')
  }
  const { result: { 0: user } } = await db.query('SELECT * FROM usuarios WHERE email = ? LIMIT 1', [email])
  let error = false
  if (!user) error = true
  else if (!bcrypt.compareSync(password, user.password)) error = true
  if (error) {
    req.flash('errores', 'Usuario o contrasena incorrectos')
    return res.redirect('/login')
  }
  req.flash('messages', 'Bienvenido')
  req.session.user = user
  if (user.gerencias_id) return res.redirect('/solicitudes')
  return res.redirect('/')
}

exports.registerForm = async (req, res) => {
  const { result: cargos } = await db.query('SELECT * FROM cargos')
  const { result: gerencias } = await db.query('SELECT g.*, d.nombre AS departamento FROM gerencias AS g LEFT JOIN departamentos AS d ON g.departamentos_id = d.id')

  return res.render('auth/register', {
    cargos,
    gerencias
  })
}

exports.register = async (req, res) => {
  try {
    const { nombre, apellido, email, password, gerencias_id, cargos_id } = req.body
    const saltRounds = 10
    const salt = bcrypt.genSaltSync(saltRounds)
    const hash = bcrypt.hashSync(password, salt)

    await db.query('INSERT INTO trabajadores (nombre, apellido, gerencias_id, cargos_id) VALUES (?, ?, ?, ?)', [nombre, apellido, gerencias_id, cargos_id])

    const id_new_trabajador = (await db.query('SELECT id FROM trabajadores WHERE nombre = ? AND apellido = ?', [nombre, apellido])).result

    const { result } = await db.query('INSERT INTO usuarios (email, password, trabajadores_id) VALUES (?, ?, ?)', [email, hash, id_new_trabajador[0].id])

    if (!result.affectedRows) {
      req.flash('errores', 'Error al agregar el usuario')
      return res.redirect('/register')
    }
    req.flash('messages', 'Trabajador registrado exitosamente')
    return res.redirect('/register')
  } catch (err) {
    console.log(err)
    req.flash('errores', 'Error al agregar el usuario')
    return res.redirect('/register')
  }
}

exports.logout = (req, res) => {
  req.session.user = null
  req.flash('messages', 'Hasta luego')
  return res.redirect('/login')
}

exports.trabajadoresIndex = async (req, res) => {
  const { result: trabajadores } = await db.query(`
    SELECT t.*, g.nombre AS gerencia, c.nombre AS cargo, d.nombre AS departamento FROM trabajadores AS t
    LEFT JOIN usuarios AS u ON t.id = u.trabajadores_id
    INNER JOIN gerencias AS g ON g.id = t.gerencias_id
    INNER JOIN cargos AS c ON c.id = t.cargos_id
    INNER JOIN departamentos AS d ON d.id = g.departamentos_id
  `)
  return res.render('trabajadores/index', {
    trabajadores
  })
}

exports.solicitudesTrabajador = async (req, res) => {
  const { result: trabajador } = await db.query('SELECT * FROM trabajadores WHERE id = ?', [req.params.id])
  const { result: solicitudes } = await db.query(`
  SELECT 
    s.codigo_solicitud,
    s.fecha_solicitud,
    es.estado as estado_solicitud,
    b.codigo AS codigo_bien,
    t.nombre AS nombre_solicitante,
    t.apellido AS apellido_solicitante,
    st.tipo AS tipo_solicitud,
    g.nombre AS gerencia,
    sd.nombre AS sede_destino,
    rep.motivo AS motivo_reparacion,
    rep.estado AS estado_reparacion,
    asig.trabajadores_id AS trabajador_asignado_id,
    t_asignado.nombre AS nombre_trabajador_asignado,
    t_asignado.apellido AS apellido_trabajador_asignado
  FROM solicitudes AS s

  INNER JOIN estados_solicitud AS es ON es.id = s.estados_solicitud_id
  INNER JOIN bienes_has_solicitudes AS bs ON bs.solicitudes_id = s.id
  INNER JOIN bienes AS b ON bs.bienes_id = b.id
  INNER JOIN trabajadores AS t ON t.id = s.trabajadores_id
  INNER JOIN solicitud_tipo AS st ON st.id = s.solicitudes_tipo
  INNER JOIN gerencias AS g ON g.id = s.gerencias_id
  LEFT JOIN traslados AS tr ON tr.solicitudes_id = s.id
  LEFT JOIN sedes AS sd ON sd.id = tr.sedes_id
  LEFT JOIN reparaciones AS rep ON rep.solicitud_id = s.id
  LEFT JOIN asignaciones AS asig ON asig.solicitud_id = s.id
  LEFT JOIN trabajadores AS t_asignado ON t_asignado.id = asig.trabajadores_id
  ${req?.session?.user?.trabajadores_id ? 'WHERE s.trabajadores_id = ' + req?.session?.user?.trabajadores_id : ''}
  WHERE t.id = ${req.params.id}
  ORDER BY s.fecha_solicitud DESC
  `)
  const agrupado = solicitudes.reduce((acc, solicitud) => {
    const codigo_solicitud = solicitud.codigo_solicitud
    const bienes = acc.find(grupo => grupo.codigo_solicitud === codigo_solicitud)
    if (!bienes) {
      acc.push({
        codigo_solicitud,
        bienes: [solicitud.codigo_bien],
        fecha_solicitud: solicitud.fecha_solicitud,
        estado_solicitud: solicitud.estado_solicitud,
        nombre_solicitante: solicitud.nombre_solicitante,
        apellido_solicitante: solicitud.apellido_solicitante,
        tipo_solicitud: solicitud.tipo_solicitud,
        gerencia: solicitud.gerencia,
        sede_destino: solicitud.sede_destino,
        motivo_reparacion: solicitud.motivo_reparacion,
        estado_reparacion: solicitud.estado_reparacion,
        trabajador_asignado_id: solicitud.trabajador_asignado_id,
        nombre_trabajador_asignado: solicitud.nombre_trabajador_asignado,
        apellido_trabajador_asignado: solicitud.apellido_trabajador_asignado
      })
    } else {
      bienes.bienes.push(solicitud.codigo_bien)
      bienes.fecha_solicitud = solicitud.fecha_solicitud
      bienes.estado_solicitud = solicitud.estado_solicitud
      bienes.nombre_solicitante = solicitud.nombre_solicitante
      bienes.apellido_solicitante = solicitud.apellido_solicitante
      bienes.tipo_solicitud = solicitud.tipo_solicitud
      bienes.gerencia = solicitud.gerencia
      bienes.sede_destino = solicitud.sede_destino
      bienes.motivo_reparacion = solicitud.motivo_reparacion
      bienes.estado_reparacion = solicitud.estado_reparacion
      bienes.trabajador_asignado_id = solicitud.trabajador_asignado_id
      bienes.nombre_trabajador_asignado = solicitud.nombre_trabajador_asignado
      bienes.apellido_trabajador_asignado = solicitud.apellido_trabajador_asignado
    }
    return acc
  }, [])

  return res.render('trabajadores/solicitudes', { solicitudes: agrupado, trabajador: trabajador[0] })
}
