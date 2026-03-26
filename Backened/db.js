const sql = require("mssql");

const config = {
    user: "sa",
    password: "123",
    server: "localhost",
    database: "students_admission",
    options: {
        trustServerCertificate: true
    }
};

console.log("db.js loaded successfully");

module.exports = {
    sql: sql,
    config: config
};