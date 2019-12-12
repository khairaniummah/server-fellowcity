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


function sendNotification(token, payload, alert){
	let options = {
		token: {
			key: "AuthKey_8YUN9AU36C.p8",
			keyId: "8YUN9AU36C",
			teamId: "64M6B7NHMY", 
		},
		production: false
	};

	let apnProvider = new apn.Provider(options);

	let deviceToken = token;

	let notification = new apn.Notification();
	notification.expirty = Math.floor(Date.now()/1000) + 24 *3600;
	notification.badge = 2;
	notification.sound = "ping.aiff";
	// notification.alert = "Nyam nyam tes tes";
	// notification.payload = {'messageFrom': 'Khairani Ummah'};
	notification.payload = payload;
	notification.alert = alert;

	notification.topic = "com.rickyeffendi.BussMeStoryboard";

	apnProvider.send(notification, deviceToken).then( result => {
		console.log(result);
	});

	apnProvider.shutdown();
}
