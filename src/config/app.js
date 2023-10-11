const express = require('express')
const path = require('path')
const session = require('express-session')
const cookieParser = require('cookie-parser')
const bodyParser = require('body-parser')
const dotenv = require('dotenv').config()

const app = express()

// SETTINGS
app.set('PORT', 3000)
app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, '../views'))

// MIDDLEWARES
app.use(cookieParser())
app.use(session({
  secret: 'keyboard cat',
  resave: false,
  saveUninitialized: true,
  cookie: {
    // secure: true
  }
}))
app.use(bodyParser.urlencoded({ extended: false }))
app.use(express.static(path.join(__dirname, '../public')))
app.use('/', require('../routes'))

module.exports = app
