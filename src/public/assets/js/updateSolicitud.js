document.querySelectorAll('.btn-success').forEach(button => {
  button.addEventListener('click', function () {
    const id = this.getAttribute('data-id')
    const tipo_solicitud = this.getAttribute('data-tipo')
    const ta_id = this.getAttribute('data-ta-id')
    const bien = this.getAttribute('data-bienes')
    updateSolicitud(id, 3, tipo_solicitud, ta_id, bien)
  })
})

document.querySelectorAll('.btn-danger').forEach(button => {
  button.addEventListener('click', function () {
    const id = this.getAttribute('data-id')
    const tipo_solicitud = this.getAttribute('data-tipo')
    updateSolicitud(id, 2, tipo_solicitud)
  })
})

document.querySelectorAll('.btn[data-state]').forEach(button => {
  button.addEventListener('click', function () {
    const id = this.getAttribute('data-id')
    const estado_reparacion = this.getAttribute('data-state')
    updateSolicitudReparacion(id, estado_reparacion)
  })
})

function updateSolicitud (id, estado_id, tipo_solicitud, ta_id, bien) {
  fetch('/solicitudes/update_estado', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ id, estado_id, tipo_solicitud, ta_id, bien })
  })
    .then(response => response.json())
    .then(data => {
      const estadoElements = document.getElementsByClassName(`estado_solicitud_${id}`)
      for (let i = 0; i < estadoElements.length; i++) {
        if (estado_id === 2) {
          estadoElements[i].textContent = 'Rechazado'
          estadoElements[i].classList.remove('bg-info')
          estadoElements[i].classList.remove('bg-success')
          estadoElements[i].classList.add('bg-danger')
        }
        if (estado_id === 3) {
          estadoElements[i].textContent = 'Aceptado'
          estadoElements[i].classList.remove('bg-info')
          estadoElements[i].classList.remove('bg-danger')
          estadoElements[i].classList.add('bg-success')
        }
      }
    })
    .catch((error) => {
      console.error('Error:', error)
    })
}

function updateSolicitudReparacion (id, estado_reparacion) {
  fetch('/solicitudes/update_reparacion', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ id, estado_reparacion })
  })
    .then(response => response.json())
    .then(data => {
      try {
        const reparacion_elemento = document.querySelector(`#estado_reparacion_${id}`)

        if (estado_reparacion === '1') {
          reparacion_elemento.setAttribute('data-state', 0)
          reparacion_elemento.textContent = 'En curso'
          reparacion_elemento.classList.remove('bg-success')
          reparacion_elemento.classList.add('bg-info')
        }
        if (estado_reparacion === '0') {
          reparacion_elemento.setAttribute('data-state', 1)
          reparacion_elemento.textContent = 'Culminada'
          reparacion_elemento.classList.remove('bg-info')
          reparacion_elemento.classList.add('bg-success')
        }
      } catch (error) {

      }
    })
    .catch((error) => {
      console.log('Error:', error)
    })
}
