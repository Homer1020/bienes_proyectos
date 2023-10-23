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
router.post('/bienes/delete/:id', bienesController.softDestroy)
router.get('/bienes/actualizar/:id', bienesController.updateForm)
router.post('/bienes/actualizar/:id', bienesController.update)

router.get('/solicitudes', solicitudesController.index)
router.get('/solicitudes/formulario', solicitudesController.create)
router.get('/solicitudes/:id', solicitudesController.show)
router.post('/solicitudes/formulario', solicitudesController.store)
router.post('/solicitudes/update_estado', solicitudesController.update)

router.get('/login', authController.loginForm)
router.post('/login', authController.login)
router.get('/register', authController.registerForm)
router.post('/register', authController.register)
router.get('/logout', authController.logout)
router.get('/trabajadores', authController.trabajadoresIndex)
router.get('/trabajadores/:id/solicitudes', authController.solicitudesTrabajador)

module.exports = router
