const { Router } = require('express')
const bienesController = require('../controllers/bienes')
const solicitudesController = require('../controllers/solicitudes')
const authController = require('../controllers/auth')
const { isAuth, isNotTrabajador, isGuest, isTrabajador } = require('../middlewares/auth')

const router = Router()

router.get('/', (req, res) => {
  return res.render('home')
})

router.get('/bienes', isAuth, isNotTrabajador, bienesController.index)
router.post('/bienes/nuevo', isAuth, isNotTrabajador, bienesController.store)
router.get('/bienes/:id', isAuth, isNotTrabajador, bienesController.show)
router.post('/bienes/delete/:id', isAuth, isNotTrabajador, bienesController.softDestroy)
router.get('/bienes/actualizar/:id', isAuth, isNotTrabajador, bienesController.updateForm)
router.post('/bienes/actualizar/:id', isAuth, isNotTrabajador, bienesController.update)

router.get('/solicitudes', isAuth, solicitudesController.index)
router.get('/solicitudes/formulario', isAuth, isTrabajador, solicitudesController.create)
router.get('/solicitudes/:id', isAuth, isTrabajador, solicitudesController.show)
router.post('/solicitudes/formulario', isAuth, isTrabajador, solicitudesController.store)
router.post('/solicitudes/update_estado', isAuth, isTrabajador, solicitudesController.update)

router.get('/login', isGuest, authController.loginForm)
router.post('/login', isGuest, authController.login)

router.get('/register', isAuth, isNotTrabajador, authController.registerForm)
router.post('/register', isAuth, isNotTrabajador, authController.register)
router.get('/logout', isAuth, authController.logout)
router.get('/trabajadores', isAuth, isNotTrabajador, authController.trabajadoresIndex)
router.get('/trabajadores/:id/solicitudes', isAuth, isNotTrabajador, authController.solicitudesTrabajador)

module.exports = router
