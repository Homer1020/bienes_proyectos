exports.loginForm = (req, res) => {
  res.render('auth/login')
}

exports.login = (req, res) => {
  res.json(req.body)
}
