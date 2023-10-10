// Renderiza detalles de un bien
exports.show = (req, res) => {
  return res.render('bienes/show')
}

// Renderiza listado bienes
exports.index = (req, res) => {
  return res.render('bienes/index')
}

// Renderiza formulario de registro de bienes
exports.create = (req, res) => {
  return res.render('bienes/create')
}
