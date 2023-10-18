const db = require('../config/db')
const crypto = require('crypto')

// Renderiza detalles de una solicitud
exports.show = (req, res) => {
  return res.render('solicitudes/show')
}

// Renderiza listado de solicitudes
exports.index = (req, res) => {
  return res.render('solicitudes/index')
}

// Renderiza formulario de creación de solicitud
exports.create = async (req, res) => {
  const query_solicitud = await db.query('SELECT * FROM solicitud_tipo')
  const query_bienes = await db.query('SELECT * FROM bienes')
  const query_sedes = await db.query('SELECT * FROM sedes')

  return res.render('solicitudes/create', {
    tipo_solicitud: query_solicitud.result,
    bienes: query_bienes.result,
    sedes: query_sedes.result
  })
}

exports.store = async (req, res) => {
  try {
    const { solicitudes_tipo, sedes_id } = req.body
    const user = req.session.user
    const bienes = req.body['bienes_id[]']
    const trabajador = (await db.query('SELECT usuarios.*, trabajadores.gerencias_id FROM usuarios LEFT JOIN trabajadores ON trabajadores.id = usuarios.trabajadores_id WHERE usuarios.id = ?', [user?.id || 1])).result
    const codigo_solicitud = crypto.randomUUID()

    const solicitud = await db.query('INSERT INTO solicitudes(codigo_solicitud, estados_solicitud_id, trabajadores_id, gerencias_id, solicitudes_tipo) VALUES (?, ?, ?, ?, ?)', [codigo_solicitud, 1, trabajador[0].trabajadores_id, trabajador[0].gerencias_id, solicitudes_tipo])

    for (const bien of bienes) {
      await db.query('INSERT INTO bienes_has_solicitudes(bienes_id, solicitudes_id) VALUES (?, ?)', [bien, solicitud.result.insertId])
    }

    await db.query('INSERT INTO traslados(solicitudes_id, sedes_id) VALUES (?, ?)', [solicitud.result.insertId, sedes_id])

    return res.json(req.body)
  } catch (err) {
    console.log(err)
  }
}
