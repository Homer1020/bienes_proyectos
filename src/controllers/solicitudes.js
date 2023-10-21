const db = require('../config/db')
const crypto = require('crypto')

// Renderiza detalles de una solicitud
exports.show = (req, res) => {
  return res.render('solicitudes/show')
}

// Renderiza listado de solicitudes
exports.index = async (req, res) => {
  const { result: solicitudes } = await db.query(`
  SELECT 
    s.codigo_solicitud,
    s.fecha_solicitud,
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

  return res.render('solicitudes/index', { solicitudes: agrupado })
}

// Renderiza formulario de creación de solicitud
exports.create = async (req, res) => {
  const tipo_solicitud = req.query.tipo || '1'
  const query_bienes = await db.query('SELECT * FROM bienes WHERE estado = 1')
  const query_sedes = await db.query('SELECT * FROM sedes')
  const query_trabajadores = await db.query('SELECT * FROM trabajadores')

  return res.render('solicitudes/create', {
    tipo_solicitud,
    bienes: query_bienes.result,
    sedes: query_sedes.result,
    trabajadores: query_trabajadores.result
  })
}

exports.store = async (req, res) => {
  try {
    const { solicitudes_tipo } = req.body
    const user = req.session.user
    const bienes = req.body['bienes_id[]']
    const trabajador = (await db.query('SELECT usuarios.*, trabajadores.gerencias_id FROM usuarios LEFT JOIN trabajadores ON trabajadores.id = usuarios.trabajadores_id WHERE usuarios.id = ?', [user?.id || 1])).result
    const codigo_solicitud = crypto.randomUUID()

    const solicitud = await db.query('INSERT INTO solicitudes(codigo_solicitud, estados_solicitud_id, trabajadores_id, gerencias_id, solicitudes_tipo) VALUES (?, ?, ?, ?, ?)', [codigo_solicitud, 1, trabajador[0].trabajadores_id, trabajador[0].gerencias_id, solicitudes_tipo])

    for (const bien of bienes) {
      await db.query('INSERT INTO bienes_has_solicitudes(bienes_id, solicitudes_id) VALUES (?, ?)', [bien, solicitud.result.insertId])
    }

    switch (solicitudes_tipo) {
      case '1': {
        const { trabajador_id } = req.body
        await db.query('INSERT INTO asignaciones(trabajadores_id, solicitud_id) VALUES (?, ?)', [trabajador_id, solicitud.result.insertId])
      }
        break

      case '2': {
        const { sedes_id } = req.body
        db.query('INSERT INTO traslados(solicitudes_id, sedes_id) VALUES (?, ?)', [solicitud.result.insertId, sedes_id])
      }
        break

      case '3': {
        const { motivo_reparacion } = req.body
        await db.query('INSERT INTO reparaciones(motivo, estado, solicitud_id) VALUES (?, ?, ?)', [motivo_reparacion, 0, solicitud.result.insertId])
      }
        break
    }
    res.redirect('/solicitudes')
  } catch (err) {
    console.log(err)
  }
}
