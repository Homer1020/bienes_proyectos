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
  const query_solicitud = await db.query('SELECT * FROM solicitud_tipo')
  const query_bienes = await db.query('SELECT * FROM bienes')
  const query_sedes = await db.query('SELECT * FROM sedes')

  return res.render('solicitudes/create', {
    tipo_solicitud: query_solicitud.result,
    bienes: query_bienes.result,
    sedes: query_sedes.result
  })
}

exports.store = async (req, res) => {
  return res.json(req.body)
}