const db = require('../config/db')
const bcrypt = require('bcrypt')

exports.loginForm = (req, res) => {
  res.render('auth/login')
}

exports.login = async (req, res) => {
  const { email, password } = req.body
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
  return res.redirect('/bienes')
}

exports.registerForm = (req, res) => {
  return res.render('auth/register')
}

exports.register = async (req, res) => {
  try {
    const { email, password } = req.body
    const saltRounds = 10
    const salt = bcrypt.genSaltSync(saltRounds)
    const hash = bcrypt.hashSync(password, salt)

    const { result } = await db.query('INSERT INTO usuarios (email, password) VALUES (?, ?)', [email, hash])
    if (!result.affectedRows) {
      req.flash('errores', 'Error al agregar el usuario')
      return res.redirect('/register')
    }
    req.flash('messages', 'Bienvenido')
    req.session.user = { email }
    return res.redirect('/')
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
