exports.isAuth = (req, res, next) => {
  if (req.session.user) return next()
  else {
    req.flash('errores', 'Accion no permitida')
    res.redirect('login')
  }
}

exports.isGuest = (req, res, next) => {
  if (!req.session.user) return next()
  res.redirect('/register')
}

exports.isTrabajador = (req, res, next) => {
  if (req.session.user.trabajadores_id) {
    return next()
  } else {
    req.flash('errores', 'Accion no permitida')
    res.redirect('/')
  }
}

exports.isNotTrabajador = (req, res, next) => {
  if (!req.session.user.trabajadores_id) {
    return next()
  } else {
    req.flash('errores', 'Accion no permitida')
    res.redirect('/')
  }
}
