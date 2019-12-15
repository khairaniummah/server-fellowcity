'user strict';

var mysql = require('mysql');

var connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "P@ssw0rd",
  database: "fellowcity"
});

connection.connect(function(err) {
  if (err) throw err;
});

module.exports = connection;