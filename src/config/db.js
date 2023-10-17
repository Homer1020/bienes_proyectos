const mysql = require('mysql2')

class Database {
  constructor () {
    this.connection = mysql.createConnection({
      host: process.env.DB_HOST || 'localhost',
      port: process.env.DB_PORT || 3306,
      database: process.env.DB_NAME || 'bienes_system',
      user: process.env.DB_USER || 'root',
      password: process.env.DB_PASSWORD || ''
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
