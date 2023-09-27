const { Router } = require('express')

const router = Router()

router.get('/bienes', (req, res) => {
  res.render('bienes')
})

router.get('/solicitudes', (req, res) => {
  res.render('solicitudes')
})

router.get('/solicitudes/detalles', (req, res) => {
  res.render('detalles_solicitudes')
})

router.get('/formulario', (req, res) => {
  res.render('formulario')
})

module.exports = router
