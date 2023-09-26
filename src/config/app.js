const express = require('express')
const path = require('path')

const app = express()

// SETTINGS
app.set('PORT', 3000)
app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, 'views'))

// MIDDLEWARES
app.use(express.static(path.join(__dirname, 'public')))
app.use('/', require('../routes'))

module.exports = app
