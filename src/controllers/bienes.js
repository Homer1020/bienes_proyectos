const db = require('../config/db')

// Renderiza detalles de un bien
exports.show = (req, res) => {
  return res.render('bienes/show')
}

// Renderiza listado bienes
exports.index = async (req, res) => {
  const { result: categorias } = await db.query('SELECT * FROM categorias')
  const { result: trabajadores } = await db.query(`
    SELECT t.*, d.nombre AS departamento FROM trabajadores AS t
    LEFT JOIN gerencias AS g ON t.gerencias_id = g.id
    LEFT JOIN departamentos AS d ON g.departamentos_id = d.id
  `)
  console.log(trabajadores)
  const { result: sedes } = await db.query('SELECT * FROM sedes')
  const { result: bienes } = await db.query(`
    SELECT b.*, c.nombre AS categoria, t.nombre AS trabajador, s.nombre AS ubicacion, g.nombre AS gerencia, d.nombre AS departamento FROM bienes AS b
    LEFT JOIN categorias AS c ON b.categorias_id = c.id
    LEFT JOIN trabajadores AS t ON b.trabajadores_id = t.id
    LEFT JOIN gerencias AS g ON t.gerencias_id = g.id
    LEFT JOIN departamentos AS d ON g.departamentos_id = d.id
    LEFT JOIN sedes AS s ON b.sedes_id = s.id
    WHERE b.estado = 1
    ORDER BY b.id DESC
  `)
  return res.render('bienes/index', {
    categorias,
    trabajadores,
    sedes,
    bienes
  })
}

exports.store = async (req, res) => {
  try {
    const { nombre, fecha_ingreso, categorias_id, trabajadores_id, sedes_id } = req.body
    const codigo = `C${categorias_id}-${nombre.toUpperCase()}-${Date.now()}`
    await db.query('INSERT INTO bienes (nombre, fecha_ingreso, categorias_id, trabajadores_id, sedes_id, codigo, estados_bien_id) VALUES (?, ?, ?, ?, ?, ?, ?)', [nombre, fecha_ingreso, categorias_id, trabajadores_id, sedes_id, codigo, 1])
    req.flash('messages', 'Se creo el bien ' + codigo)
  } catch (error) {
    console.log(error)
    req.flash('errores', 'Error al crear el bien')
  }
  res.redirect('/bienes')
}

exports.softDestroy = async (req, res) => {
  try {
    await db.query('UPDATE bienes SET estado = 0 WHERE id = ?', [req.params.id])
    req.flash('messages', 'Se elimino el bien')
    return res.redirect('/bienes')
  } catch (err) {
    req.flash('errors', 'Algo salio mal')
    res.redirect('/bienes')
  }
}
