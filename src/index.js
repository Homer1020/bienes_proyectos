const app = require('./config/app')

app.listen(app.get('PORT'), () => {
  console.log('Server in port ' + app.get('PORT'))
})
