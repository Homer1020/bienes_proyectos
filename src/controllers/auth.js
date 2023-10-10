const db = require('../config/db')
const bcrypt = require('bcrypt')

exports.loginForm = (req, res) => {
  res.render('auth/login')
}

exports.login = async (req, res) => {
  const { email, password } = req.body
  const { result: { 0: user } } = await db.query('SELECT * FROM usuarios WHERE email = ? LIMIT 1', [email])
  if (!user) return res.json({ ok: false })
  if (!bcrypt.compareSync(password, user.password)) return res.json({ ok: false })
  req.session.user = user
  return res.redirect('/')
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
    if (!result.affectedRows) return res.json({ ok: false })
    return res.json({ ok: true })
  } catch (err) {
    return res.json({ ok: false })
  }
}
