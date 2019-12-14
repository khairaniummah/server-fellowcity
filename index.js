const express = require('express');
const bodyParser = require('body-parser');
const apn = require('apn');
const app = express();
const mysql = require('mysql');
const port = process.env.PORT || 3000;
const http = require('http');
const cron = require('cron');
const moment = require('moment');
const _ = require('lodash');
// const dayjs = require('dayjs');
const getTimestamp = require('date-fns/getTime')
 
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
  notification.payload = {'messageFrom': 'Khairani Ummah'};
  // notification.payload = payload;
  notification.alert = alert;

  notification.topic = "com.rickyeffendi.BussMeStoryboard";

  apnProvider.send(notification, deviceToken).then( result => {
    console.log(result);
  });

  apnProvider.shutdown();
}

//------------------------------------------------------------------------------------------------------------
//---------------------------------SEND NOTIFICATION----------------------------------------------------------
// get list of notification 


function getTodayNotificationList(){
  var today = 6;  //-- harinya (senin-selasa dst)
  let sql = "SELECT * FROM notifications  WHERE day = "+today+" ORDER BY time ASC";
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    console.log(results);
    return results;
    // return (JSON.stringify({"status": 200, "error": null, "response": results}));
  });
  console.log(today);
  console.log(sql);
}

let notificationList = getTodayNotificationList();
console.log(notificationList);

function sendAllNotification(){
  notificationList.forEach((item, index) => {
    let data = {token: item.token_id, 
              payload: {'messageFrom': 'Khairani Ummah'}, 
              alert: "mamaa ngantuk",
              time: `00 ${moment(item.time).format('mm')} ${moment(item.time).format('h')} * * *` };
    var cronJob = cron.job(data.time, function(){
      sendNotification(data.token, data.payload, data.alert);
      console.info('cron job completed');
    }); 
    cronJob.start();
    console.log(data.time);
});
}




//------------------------------------------------------------------------------------------------------------
// add row on Notification Table
app.post('/notification',(req, res) => {
    // let time = getTimestamp(new Date(req.body.time))
    let data = {reminder_id: req.body.reminder_id, token_id: req.body.token_id, time: req.body.time};
    let sql = "INSERT INTO notifications SET ?";
    let query = conn.query(sql, data,(err, results) => {
      if(err) throw err;
      res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    })
    console.log("request:" ,req);
    console.log(data);
});

function timeFormat(time){
    let separated = time.split(" ")
    let part1 = separated[0].split("-")
    let part2 = separated[1].split(":")
    let year = Number(part1[0])
    let month = Number(part1[1])
    let date = Number(part1[2])
    let hour = Number(part1[0])
    let minute = Number(part1[1])
    let second = Number(part1[2])
    return ({year, month, date, hour, minute, second})
}



// -----------------------------------------------QUERIES---------------------------------------------------------------------
//add new user
app.post('/api/user',(req, res) => {
  let data = {uuid: req.body.uuid, token_id: req.body.token_id, name: req.body.name, created_at: moment(Date.now()).format('YYYY-MM-DD HH:mm:ss')};
  let sql = "INSERT INTO users SET ?";
  let query = conn.query(sql, data,(err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
  });
  console.log("request:" ,req);
  console.log(data);
});


//get user token ID based on uuid and latest on db
app.get('/api/user-token/:uuid',(req, res) => {
  let sql = "SELECT token_id FROM users WHERE uuid='"+req.params.uuid+"' ORDER BY created_at DESC LIMIT 1";
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    // res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    console.log(results[0].token_id);
    res.status(200).send(results[0].token_id);
  });
  console.log(sql);
  // console.log(results.token_id);
});

//get list of routes (breeze - ice) dkk
app.get('/api/routes',(req, res) => {
  let sql = "SELECT DISTINCT departure_stop,  arrival_stop, direction, bus_code, route from trips left join buses on trips.bus_id = buses.id";
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
  });
});

//get list stop all
app.get('/api/stops/',(req, res) => {
  let sql = "SELECT direction, stop_name, bus_code from stops join buses on stops.bus_id = buses.id order by bus_id, direction, order_no ASC";
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": _.groupBy(results, "bus_code", "direction")}));
  });
  console.log(sql);
  // console.log(results.token_id);
});

// get stops, long, lat based on direction & bus_code
app.get('/api/stops/:bus_id/:direction',(req, res) => {
  let sql = "SELECT direction, stop_name, longitude, latitude, order_no from stops where bus_id = "+req.params.bus_id+" and direction = '"+req.params.direction+"' order by direction, order_no ASC";
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
  });
  console.log(sql);
  // console.log(results.token_id);
});

//-----------------------------------------------COMMUTE---------------------------------------------------------------------
// 1. get list of bus
app.get('/api/buses',(req, res) => {
  let sql = "SELECT * FROM buses";
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
  });
});

// 2. get list stop based on routes (departure, return) -- selected bus_id
app.get('/api/stops/:bus_id',(req, res) => {
  let sql = "SELECT direction, stop_name, id as stop_id from stops where bus_id = "+req.params.bus_id+" order by direction, order_no ASC";
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": _.groupBy(results, "direction")}));
  });
  console.log(sql);
  // console.log(results.token_id);
});

// 2b. get list stop based on routes (departure, return) -- selected bus_id & direction
app.get('/api/stops/:bus_id/:direction',(req, res) => {
  let sql = "SELECT direction, stop_name, id as stop_id from stops where bus_id = "+req.params.bus_id+" and direction = '"+req.params.direction+"' order by order_no ASC";
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": _.groupBy(results, "direction")}));
  });
  console.log(sql);
  // console.log(results.token_id);
});

//3. get from schedule with parameter : stop_id & direction
app.get('/api/schedule/stop/:stop_id',(req, res) => {
  let sql = "SELECT * from schedules where stop_id = "+req.params.stop_id+" order by order_no ASC";
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": _.groupBy(results, "direction")}));
  });
  console.log(sql);
  // console.log(results.token_id);
});

//4. get from schedule with parameter : trip_id
app.get('/api/schedule/trip/:trip_id',(req, res) => {
  let sql = "SELECT * from schedules where trip_id = "+req.params.trip_id+" order by order_no ASC";
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": _.groupBy(results, "direction")}));
  });
  console.log(sql);
  // console.log(results.token_id);
});

// 5. upload data check (naik turun)
app.post('/api/commute/',(req, res) => {
  let data = {user_id: req.body.user_id, stop_id: req.body.stop_id, longitude: req.body.longitude, latitude: req.body.latitude, status_check: req.body.status_check, created_at: moment(Date.now()).format('YYYY-MM-DD HH:mm:ss')};
  let sql = "INSERT INTO commutes SET ?";
  let query = conn.query(sql, data,(err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
  });
  console.log("request:" ,req);
  console.log(data);
});

//-----------------------------------------------REMINDER------------------------------------------------------------------
// 1. Add Reminder
app.post('/api/reminder/add',(req, res) => {
  let data = {user_id: req.body.user_id, stop_id: req.body.stop_id, stop_name: req.body.stop_name, bus_code: req.body.bus_code, 
              direction: req.body.direction, interval_start: req.body.interval_start, interval_stop: req.body.interval_stop, 
              time_before_arrival: req.body.time_before_arrival, repeat: JSON.stringify(req.body.repeat), is_active: 1,
              created_at: moment(Date.now()).format('YYYY-MM-DD HH:mm:ss')};
  let sql = "INSERT INTO reminders SET ?";
  let query = conn.query(sql, data,(err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
  });
  console.log("request:" ,req);
  console.log(data);
});

// 2. Update is_active
app.put('/api/reminder/update-active/:id',(req, res) => {
  let sql = "UPDATE reminders SET stop_id ="+ req.body.stop_id+", stop_name ="+ req.body.stop_name+", bus_code ="+ req.body.bus_code +", direction = "+ req.body.direction +", interval_start = "+req.body.interval_start+", interval_stop = "+ req.body.interval_stop+
  ", time_before_arrival = "+req.body.time_before_arrival+", repeat = "+req.body.repeat+", is_active='"+req.body.is_active+"', updated_at='"+moment(Date.now()).format('YYYY-MM-DD HH:mm:ss')+
            "'WHERE id="+req.params.id;
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
  });
});

//3. Update reminder all properties
app.put('/api/reminder/update/:id',(req, res) => {
  let sql = "UPDATE reminders SET is_active='"+req.body.is_active+"', updated_at='"+moment(Date.now()).format('YYYY-MM-DD HH:mm:ss')+
            "'WHERE id="+req.params.id;
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
  });
});


//4. Get reminder per user
app.get('/api/reminder/user/:user_id',(req, res) => {
  let sql = "SELECT * from reminder where user_id = "+req.params.user_id+" order by created_at DESC";
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
  });
  console.log(sql);
  // console.log(results.token_id);
});

//5. Get reminder per id reminder
app.get('/api/reminder/item/:reminder_id',(req, res) => {
  let sql = "SELECT * from reminder where reminder_id = "+req.params.reminder_id+" ";
  let query = conn.query(sql, (err, results) => {
    if(err) throw err;
    res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
  });
  console.log(sql);
  // console.log(results.token_id);
});



 
//Server listening
app.listen(port,() =>{
  console.log('Server running at port '+port);
});