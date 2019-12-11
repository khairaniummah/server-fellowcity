const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const mysql = require('mysql');
const port = process.env.PORT || 3000;
const http = require('http');
 
// parse application/json
app.use(bodyParser.json()); 

const isDev = process.env.NODE_ENV === 'development'
 
//create database connection
const conn = mysql.createConnection({
  host: isDev ? 'localhost' : process.env.HOST,
  user: isDev ? 'root' : process.env.USER,
  password: isDev ? 'P@ssw0rd' :process.env.PASSWORD,
  database: isDev ? 'fellowcity' :process.env.DATABASE

});
 
//connect to database
conn.connect((err) =>{
  if(err) throw err;
  console.log('Mysql Connected...');
});
 
//show all products
app.get('/api/trips',(req, res) => {
  let sql = "SELECT * FROM trips";
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
  });
});
 
//show single product
app.get('/api/trips/:id',(req, res) => {
  let sql = "SELECT * FROM trips WHERE id="+req.params.id;
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
  });
});
 
//add new product
app.post('/api/user',(req, res) => {
  let data = {uuid: req.body.uuid, token_id: req.body.token_id, name: req.body.name};
  let sql = "INSERT INTO users SET ?";
  let query = conn.query(sql, data,(err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
  });
  console.log("request:" ,req);
  console.log(data);
});
 
//update product
app.put('/api/products/:id',(req, res) => {
  let sql = "UPDATE product SET product_name='"+req.body.product_name+"', product_price='"+req.body.product_price+"' WHERE product_id="+req.params.id;
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
  });
});
 
//Delete product
app.delete('/api/products/:id',(req, res) => {
  let sql = "DELETE FROM product WHERE product_id="+req.params.id+"";
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
      res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
  });
});


const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/html');
  res.end('<h1>Hello World</h1>');
});
 
//Server listening
app.listen(port,() =>{
  console.log('Server running at port '+port);
});