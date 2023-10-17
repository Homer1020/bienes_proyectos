/* eslint no-use-before-define: 0 */

$(document).ready(function () {
  $('#modal_create_bien .select2').select2({
    dropdownParent: $('#modal_create_bien'),
    theme: 'bootstrap-5'
  })
})

$(document).ready(function () {
  $(':not(#modal_create_bien) .select2').select2({
    theme: 'bootstrap-5'
  })
})

const alert = window.bootstrap.Alert.getOrCreateInstance('.message-app')
if (alert) {
  setTimeout(() => {
    alert.close()
  }, 2000)
}
