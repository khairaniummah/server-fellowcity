"use strict";

//Build Notification
const apn = require('apn');
const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const mysql = require('mysql');

const conn = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'P@ssw0rd',
  database: 'fellowcity'
});
 
//connect to database
conn.connect((err) =>{
  if(err) throw err;
  console.log('Mysql Connected...');
});

app.listen(3000,() =>{
  console.log('Server started on port 3000...');
});

var routes = require('./routes/appRoutes'); //importing route
routes(app); //register the route

app.get('/reni', (req, res) => {
	res.send('Hello')
})

// let options = {
// 	token: {
// 		key: "AuthKey_8YUN9AU36C.p8",
// 		keyId: "8YUN9AU36C",
// 		teamId: "64M6B7NHMY", 
// 	},
// 	production: false
// };

// let apnProvider = new apn.Provider(options);

// let deviceToken = "1E302C775EFABA47F576136E54ED9938F45CEFEC52D16B8FC754B543E7E1BD86";

// let notification = new apn.Notification();
// notification.expirty = Math.floor(Date.now()/1000) + 24 *3600;
// notification.badge = 2;
// notification.sound = "ping.aiff";
// notification.alert = "Nyam nyam tes tes";
// notification.payload = {'messageFrom': 'Khairani Ummah'};

// notification.topic = "com.rickyeffendi.BussMeStoryboard";

// apnProvider.send(notification, deviceToken).then( result => {
// 	console.log(result);
// });

// apnProvider.shutdown();