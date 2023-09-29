const app = require('./config/app')
const routes = require('./routes/index')

app.get('/formulario', routes)
app.get('/bienes', routes)
app.get('/solicitudes', routes)
app.get('/solicitudes/detalles', routes)

app.listen(app.get('PORT'), () => {
  console.log('Server in port ' + app.get('PORT'))
})
