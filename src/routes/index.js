const { Router } = require('express')

const router = Router()

router.get('/', (req, res) => {
  return res.render('home')
})

router.get('/bienes', (req, res) => {
  return res.render('bienes/index')
})

router.get('/solicitudes', (req, res) => {
  return res.render('solicitudes/index')
})

router.get('/solicitudes/detalles', (req, res) => {
  return res.render('solicitudes/show')
})

module.exports = router
