const { Router } = require('express')
const bienesController = require('../controllers/bienes')
const solicitudesController = require('../controllers/solicitudes')
const authController = require('../controllers/auth')

const router = Router()

router.get('/', (req, res) => {
  return res.render('home')
})

router.get('/bienes', bienesController.index)
router.post('/bienes/nuevo', bienesController.store)
router.get('/bienes/:id', bienesController.show)

router.get('/solicitudes', solicitudesController.index)
router.get('/solicitudes/formulario', solicitudesController.create)
router.get('/solicitudes/:id', solicitudesController.show)

router.get('/login', authController.loginForm)
router.post('/login', authController.login)
router.get('/register', authController.registerForm)
router.post('/register', authController.register)

module.exports = router
