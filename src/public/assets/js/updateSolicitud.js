document.querySelectorAll('.btn-success').forEach(button => {
  button.addEventListener('click', function () {
    const id = this.getAttribute('data-id')
    updateSolicitud(id, 3)
  })
})

document.querySelectorAll('.btn-danger').forEach(button => {
  button.addEventListener('click', function () {
    const id = this.getAttribute('data-id')
    updateSolicitud(id, 2)
  })
})

function updateSolicitud (id, estado_id) {
  fetch('/solicitudes/update_estado', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ id, estado_id })
  })
    .then(response => response.json())
    .then(data => {
      const estadoElements = document.getElementsByClassName(`estado_solicitud_${id}`)
      for (let i = 0; i < estadoElements.length; i++) {
        if (estado_id === 2) {
          estadoElements[i].textContent = 'Rechazado'
          estadoElements[i].classList.remove('bg-info')
          estadoElements[i].classList.add('bg-danger')
        }
        if (estado_id === 3) {
          estadoElements[i].textContent = 'Aceptado'
          estadoElements[i].classList.remove('bg-danger')
          estadoElements[i].classList.add('bg-success')
        }
      }
    })
    .catch((error) => {
      console.error('Error:', error)
    })
}
