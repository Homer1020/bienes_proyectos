const { Router } = require('express')
const bienesController = require('../controller/bienes')
const solicitudesController = require('../controller/solicitudes')

const router = Router()

router.get('/', (req, res) => {
  const countViews = req.session.count || 0
  req.session.count = countViews + 1
  return res.json(countViews)
})

router.get('/bienes', bienesController.index)
router.get('/bienes/nuevo', bienesController.create)
router.get('/bienes/:id', bienesController.show)

router.get('/solicitudes', solicitudesController.index)
router.get('/solicitudes/nuevo', solicitudesController.create)
router.get('/solicitudes/:id', solicitudesController.show)

module.exports = router
