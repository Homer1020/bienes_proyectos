const mysql = require('mysql2')

class Database {
  constructor () {
    this.connection = mysql.createConnection({
      host: process.env.DB_HOST,
      port: process.env.DB_PORT,
      database: process.env.DB_NAME,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD
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
