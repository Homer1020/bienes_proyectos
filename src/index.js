const app = require('./config/app')
const routes = require('./routes/index')

app.use('/formulario', routes)
app.use('/bienes', routes)
app.use('/solicitudes', routes)
app.use('/solicitudes/detalles', routes)

app.listen(app.get('PORT'), () => {
  console.log('Server in port ' + app.get('PORT'))
})
