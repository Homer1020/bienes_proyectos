/* eslint no-use-before-define: 0 */

$(document).ready(function () {
  if (document.querySelector('#modal_create_bien')) {
    $('.select2-onmodal').select2({
      dropdownParent: $('#modal_create_bien'),
      theme: 'bootstrap-5'
    })
  } else {
    $('.select2').select2({
      theme: 'bootstrap-5'
    })
  }
})

Array.from(document.querySelectorAll('.message-app')).forEach(el => {
  const alert = window.bootstrap.Alert.getOrCreateInstance(el)
  if (alert) {
    setTimeout(() => {
      alert.close()
    }, 3000)
  }
})

$(document).ready(function () {
  $('#bienes-table').DataTable({
    ordering: false,
    responsive: true
  })

  $('#solicitudes-table').DataTable({
    responsive: true,
    ordering: false
  })
})
