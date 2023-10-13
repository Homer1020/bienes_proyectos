const db = require('../config/db')

// Renderiza detalles de una solicitud
exports.show = (req, res) => {
  return res.render('solicitudes/show')
}

// Renderiza listado de solicitudes
exports.index = (req, res) => {
  return res.render('solicitudes/index')
}

// Renderiza formulario de creación de solicitud
exports.create = async (req, res) => {
  const tipo = req.query.tipo ?? 1
  const id_departamento = req.query.departamento ?? 1

  const query_solicitud = await db.query('SELECT * FROM solicitud_tipo')
  const query_departamento = await db.query('SELECT * FROM departamentos')
  const query_trabajadores = await db.query('SELECT t.id, t.nombre, t.apellido FROM trabajadores as t INNER JOIN gerencias as g ON g.id = t.gerencias_id WHERE g.departamentos_id = ?', [id_departamento])
  const query_bienes = await db.query('SELECT codigo, nombre FROM bienes')

  return res.render('solicitudes/create', {
    tipo,
    id_departamento,
    tipo_solicitud: query_solicitud.result,
    solicitud_departamento: query_departamento.result,
    solicitud_trabajadores: query_trabajadores.result,
    codigo_bienes: query_bienes.result
  })
}
