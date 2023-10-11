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
  const q = await db.query('SELECT * FROM solicitud_tipo')

  return res.render('solicitudes/create', { tipo, tipo_solicitud: q.result })
}
