const mysql = require('mysql2')

class Database {
  constructor () {
    this.connection = mysql.createConnection({
      host: 'localhost',
      port: 3306,
      database: 'bienes_system',
      user: 'root',
      password: ''
    })
  }

  query (q, params = []) {
    return new Promise((resolve, reject) => {
      this.connection.query(q, params, (err, result, fields) => {
        if (err) reject(err)
        resolve({ result, fields })
      })
    })
  }
}

module.exports = new Database()
