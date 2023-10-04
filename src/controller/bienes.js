exports.show = (req, res) => {
  return res.render('bienes/show')
}

exports.index = (req, res) => {
  return res.render('bienes/index')
}

exports.create = (req, res) => {
  return res.render('bienes/create')
}
