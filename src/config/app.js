const express = require('express')
const path = require('path')
const session = require('express-session')
const cookieParser = require('cookie-parser')
const bodyParser = require('body-parser')
const flash = require('connect-flash')
require('dotenv').config()

const app = express()

// SETTINGS
app.set('PORT', 3000)
app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, '../views'))

// MIDDLEWARES
app.use(express.json())
app.use(cookieParser())
app.use(session({
  secret: 'keyboard cat',
  resave: false,
  saveUninitialized: true,
  cookie: {
    // secure: true
  }
}))
app.use(flash())
app.use((req, res, next) => {
  res.locals.messages = req.flash('messages')
  res.locals.errores = req.flash('errores')
  res.locals.user = req.session.user
  function formatDate (date) {
    const day = date.getDate()
    const month = date.getMonth() + 1 // JavaScript months are zero-indexed
    const year = date.getFullYear()

    // Add leading zeros to the day and month if necessary
    const dayStr = day < 10 ? `0${day}` : `${day}`
    const monthStr = month < 10 ? `0${month}` : `${month}`

    // Return the formatted date string
    return `${year}-${monthStr}-${dayStr}`
  }
  res.locals.formatDate = formatDate
  return next()
})
app.use(bodyParser.urlencoded({ extended: false }))
app.use(express.static(path.join(__dirname, '../public')))
app.use('/', require('../routes'))

module.exports = app
