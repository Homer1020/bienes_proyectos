// Renderiza detalles de una solicitud
exports.show = (req, res) => {
  return res.render('solicitudes/show')
}

// Renderiza listado de solicitudes
exports.index = (req, res) => {
  return res.render('solicitudes/index')
}

// Renderiza formulario de creación de solicitud
exports.create = (req, res) => {
  const tipo = req.query.tipo ?? 'asignacion'

  return res.render('solicitudes/create', { tipo })
}
