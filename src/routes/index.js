const { Router } = require('express')

const router = Router()

router.get('/', (req, res) => {
  res.send('<h1>Hola Mundo</h1>')
})

router.get("") //Hacer ruta de formulario de solicitudes de bienes

module.exports = router
