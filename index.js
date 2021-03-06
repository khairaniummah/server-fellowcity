const express = require("express");
const bodyParser = require("body-parser");
const apn = require("apn");
const app = express();
const mysql = require("mysql");
const port = process.env.PORT || 3000;
const cron = require("cron");
const moment = require("moment");
const _ = require("lodash");

const { formatTime, calculateReminderTime } = require("./helper");

// parse application/json
app.use(bodyParser.json());

const isDev = process.env.NODE_ENV === "development";

//create database connection
const conn = mysql.createConnection({
  host: isDev ? "localhost" : process.env.HOST,
  user: isDev ? "root" : process.env.USER,
  password: isDev ? "P@ssw0rd" : process.env.PASSWORD,
  database: isDev ? "fellowcity" : process.env.DATABASE
});

//connect to database
conn.connect(err => {
  if (err) throw err;
  console.log("Mysql Connected...");
});

function sendNotification(token, payload, alert) {
  let options = {
    token: {
      key: "AuthKey_8YUN9AU36C.p8",
      keyId: "8YUN9AU36C",
      teamId: "64M6B7NHMY"
    },
    production: false
  };

  let apnProvider = new apn.Provider(options);

  let deviceToken = token;

  let notification = new apn.Notification();
  notification.expirty = Math.floor(Date.now() / 1000) + 24 * 3600;
  notification.badge = 2;
  notification.sound = "ping.aiff";
  // notification.alert = "Nyam nyam tes tes";
  notification.payload = { messageFrom: "Khairani Ummah" };
  // notification.payload = payload;
  notification.alert = alert;

  notification.topic = "com.rickyeffendi.BussMeStoryboard";

  apnProvider.send(notification, deviceToken).then(result => {
    console.log(result);
  });

  apnProvider.shutdown();
}

//------------------------------------------------------------------------------------------------------------
//---------------------------------SEND NOTIFICATION----------------------------------------------------------
// get list of notification
function getTodayNotificationList() {
  let today = new Date();
  let intToday = today.getDay();
   //-- harinya (senin-selasa dst)
  let sql =
    "SELECT * FROM notifications join reminders on reminders.id = notifications.reminder_id WHERE day = " +
    intToday +
    " and reminders.is_active = 1 ORDER BY time ASC";
  let query = conn.query(sql, (err, results) => {
    if (err) throw err;
    console.log("getTodayNotificationList: ", sql);
    // console.log("apakah ini", results);
    sendAllNotification(results);
    // sendOneNotification();
    // return results;
    // return (JSON.stringify({"status": 200, "error": null, "response": results}));
  });
  console.log(sql);
}

function sendAllNotification(notificationList) {
  notificationList.forEach(item => {
    let parsedTime = formatTime(item.time);
    let data = {
      token: item.token_id,
      payload: { messageFrom: "Khairani Ummah" },
      alert: "",
      time: `00 ${parsedTime.m} ${parsedTime.h} * * ${item.day}`
    };
    var cronJob = cron.job(data.time, function() {
      sendNotification(data.token, data.payload, data.alert);
      console.info("cron job completed");
    });
    cronJob.start();
    // console.log("time", data.time);
  });
}

function sendOneNotification(){
      let data = {
        token: "734AF116339DB6746C2BE5455D2E30E8889B0893BD68FB65C83F6C45A8AAF83C",
        payload: { messageFrom: "Khairani Ummah" },
        alert: {
         "title" : "Your bus is arriving in 30 minutes 🏃🏻‍♂️",
         // "subtitle" : "BRE: Breeze - Ice is coming",
         "body" : "Prepare yourself! Your bus BRE: Breeze - Ice will arrive at The Breeze stop soon" }
        // time: `00 ${parsedTime.m} ${parsedTime.h} * * ${item.day}`
      };
        sendNotification(data.token, data.payload, data.alert);
        console.info("hehe");
      // cronJob.start();
      console.log("hey");
}



//------------------------------------------------------------------------------------------------------------
//-----------------CALCULATE REMINDER - NOTIFICATION------------------------------------
// hitung exact time to send notification for each reminder based on schedule
function calculateReminder(reminder_id) {
  let query1 = "SELECT * FROM reminders join users on reminders.user_id = users.id where reminders.id = "+reminder_id;
  conn.query(query1, (err, reminderData) => {
    if (err) throw err;
    // console.log(reminderData[0])
    var is_weekend = reminderData[0].repeats == "weekend" || reminderData[0].repeats == "all";
    var repeatDay = is_weekend ? [6,7] : reminderData[0].repeats == "weekday" ? [1, 2,3,4,5] : [1, 2,3,4,5,6,7];

    let sql =
      "SELECT * FROM daily_schedules join trips on schedules.trip_id = trips.id where trips.bus_id = " +
      reminderData[0].bus_id +
      " and direction = '" +
      reminderData[0].direction +
      "' and is_weekend = " +
      is_weekend +
      " and stop_id = " +
      reminderData[0].stop_id +
      " and time_arrival < '" +
      reminderData[0].interval_stop +
      "' and time_arrival > '" +
      reminderData[0].interval_start +
      "' ";

    console.log("SQL: ", sql);

    conn.query(sql, (err, results) => {
      if (err) throw err;

      console.log("RESULTS: ", results);

      // kurangin si schedule dengan time_before_arrival
      let dataWithReminderTime = results.map(item => {
        let calculation = calculateReminderTime(
          item.time_arrival,
          reminderData[0].time_before_arrival
        );
        return calculation.remindTime;
      });

      let reminderTimeList = [];
      repeatDay.map(day => {
        dataWithReminderTime.map(time => {
          reminderTimeList.push({ day: day, time: time });
        });
      });

      console.log("REMINDER LIST: ", reminderTimeList);
      dropNotification(reminder_id, addNotification(reminderData[0].reminder_id, token_id, reminderTimeList));
      return dataWithReminderTime;
    });
  });
}

function dropNotification(reminder_id, callback) {
  let sql = "DELETE FROM notifications WHERE reminder_id = " + reminder_id
  let query = conn.query(sql, data, (err, results) => {
      if (err) throw err;
      callback();
      // return JSON.stringify({ status: 200, error: null, response: results });
    });
}

function addNotification(reminder_id, token_id, reminderTimeList) {
  // masukin calculateReminder ke tabel notification
  // nyimpen jam (4) x jumlah harinya kan
  reminderTimeList.forEach(item => {
    let data = {
      reminder_id: reminder_id,
      token_id: token_id,
      day: item.day,
      time: item.time,
      created_at: moment(Date.now()).format("YYYY-MM-DD HH:mm:ss")
    };
    let sql = "INSERT INTO notifications SET ?";
    let query = conn.query(sql, data, (err, results) => {
      if (err) throw err;
      return JSON.stringify({ status: 200, error: null, response: results });
    });
  });
}

function updateNotifBasedOnCommute() {
  //
}
// --------MAIN-----------
// calculateReminder(1, 1, "depart", 2, 20, "10:00:00", "11:00:00", "weekday");
getTodayNotificationList();
// dailyCronJob();
console.log("mantap")
// --------MAIN-----------

function dailyCronJob() {
    var cronJob = cron.job('2 * * * * *', function() {
      console.info("Daily cron job completed");
      getDailyActiveReminder(calculateReminder);
      console.log("mau pulang")
    });
    cronJob.start();
}

function getDailyActiveReminder(callback) {
  // ambil semua active reminder
  let sql = "SELECT id as reminder_id FROM reminders WHERE is_active = 1";
  conn.query(sql, (err, result) => {
    if (err) throw err;
    result.forEach(reminder_id => {
      callback(reminder_id)
      console.log(reminder_id)
    })
  });
}

function getTokenById(user_id){
  let query1 = "SELECT token_id FROM users where id = "+user_id+" ORDER BY created_at DESC LIMIT 1";
  conn.query(query1, (err, result) => {
    if (err) throw err;
    // return result[0].token_id;
    // console.log(result[0].token_id)
  });
}

//------------------------------------------------------------------------------------------------------------
// add row on Notification Table
app.post("/notification", (req, res) => {
  // let time = getTimestamp(new Date(req.body.time))
  let data = {
    reminder_id: req.body.reminder_id,
    token_id: req.body.token_id,
    time: req.body.time
  };
  let sql = "INSERT INTO notifications SET ?";
  let query = conn.query(sql, data, (err, results) => {
    if (err) throw err;
    res.send(JSON.stringify({ status: 200, error: null, response: results }));
  });
  console.log("request:", req);
  console.log(data);
});

// -----------------------------------------------QUERIES---------------------------------------------------------------------
//add new user
app.post("/api/user", (req, res) => {
  let data = {
    uuid: req.body.uuid,
    token_id: req.body.token_id,
    name: req.body.name,
    created_at: moment(Date.now()).format("YYYY-MM-DD HH:mm:ss")
  };
  let sql = "INSERT INTO users SET ?";
  let query = conn.query(sql, data, (err, results) => {
    if (err) throw err;
    res.send(JSON.stringify({ status: 200, error: null, response: results }));
  });
  console.log("request:", req);
  console.log(data);
});

//get user token ID based on uuid and latest on db
app.get("/api/user-token/:uuid", (req, res) => {
  let sql =
    "SELECT token_id FROM users WHERE uuid='" +
    req.params.uuid +
    "' ORDER BY created_at DESC LIMIT 1";
  let query = conn.query(sql, (err, results) => {
    if (err) throw err;
    // res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    console.log(results[0].token_id);
    res.status(200).send(results[0].token_id);
  });
  console.log(sql);
  // console.log(results.token_id);
});

//get list of routes (breeze - ice) dkk
app.get("/api/routes", (req, res) => {
  let sql =
    "SELECT DISTINCT departure_stop,  arrival_stop, direction, bus_code, route from trips left join buses on trips.bus_id = buses.id";
  let query = conn.query(sql, (err, results) => {
    if (err) throw err;
    res.send(JSON.stringify({ status: 200, error: null, response: results }));
  });
});

//get list stop all
app.get("/api/stops/all", (req, res) => {
  let sql =
    "SELECT longitude, latitude, order_no, direction, stop_name, id as stop_id from stops join buses on stops.bus_id = buses.id order by bus_id, direction, order_no ASC";
  let query = conn.query(sql, (err, results) => {
    if (err) throw err;
    res.send(
      JSON.stringify({
        status: 200,
        error: null,
        response: _.groupBy(results, "bus_code", "direction")
      })
    );
  });
  console.log(sql);
  // console.log(results.token_id);
});

// get stops, long, lat based on direction & bus_code
// app.get("/api/stops/:bus_id/:direction", (req, res) => {
//   let sql =
//     "SELECT direction, stop_name, longitude, latitude, order_no from stops where bus_id = " +
//     req.params.bus_id +
//     " and direction = '" +
//     req.params.direction +
//     "' order by direction, order_no ASC";
//   let query = conn.query(sql, (err, results) => {
//     if (err) throw err;
//     res.send(JSON.stringify({ status: 200, error: null, response: results }));
//   });
//   console.log(sql);
//   // console.log(results.token_id);
// });

//-----------------------------------------------COMMUTE---------------------------------------------------------------------
// 1. get list of bus
app.get("/api/buses", (req, res) => {
  let sql = "SELECT * FROM buses";
  let query = conn.query(sql, (err, results) => {
    if (err) throw err;
    res.send(JSON.stringify({ status: 200, error: null, response: results }));
  });
});

// 2. get list stop based on routes (departure, return) -- selected bus_id
app.get("/api/stops/bus/:bus_id", (req, res) => {
  let sql =
    "SELECT longitude, latitude, order_no, direction, stop_name, id as stop_id from stops where bus_id = " +
    req.params.bus_id +
    " order by direction, order_no ASC";
  let query = conn.query(sql, (err, results) => {
    if (err) throw err;
    res.json({stops: results});
    // console.log(_.groupBy(results, "direction"))
  });
  // console.log(sql);
  // console.log(results.token_id);
});

// 2b. get list stop based on routes (departure, return) -- selected bus_id & direction
app.get("/api/stops/direction/:bus_id/:direction", (req, res) => {
  let sql =
    "SELECT longitude, latitude, order_no, direction, stop_name, id as stop_id from stops where bus_id = " +
    req.params.bus_id +
    " and direction = '" +
    req.params.direction +
    "' order by order_no ASC";
  let query = conn.query(sql, (err, results) => {
    if (err) throw err;
    res.json({stops: results});
  });
  console.log(sql);
  // console.log(results.token_id);
});

//get all schedules
app.get("/api/schedule/all", (req, res) => {
  let sql = "SELECT * from daily_schedules";
  let query = conn.query(sql, (err, results) => {
    if (err) throw err;
    res.send(JSON.stringify({ status: 200, error: null, response: results }));
  });
  console.log("hay: " + req.params.stop_id);
});


//3. get from schedule with parameter : stop_id
app.get("/api/schedule/stop/:stop_id", (req, res) => {
  let sql = "SELECT * from daily_schedules where stop_id = " +req.params.stop_id;
  let query = conn.query(sql, (err, results) => {
    if (err) throw err;
    res.json({schedules: results});
  });
});

//4. get from schedule with parameter : trip_id
app.get("/api/schedule/trip/:trip_id", (req, res) => {
  let sql =
    "SELECT * from daily_schedules where trip_id = " +
    req.params.trip_id +
    " order by stop_id ASC";
  let query = conn.query(sql, (err, results) => {
    if (err) throw err;
    res.json({schedules: results});
  });
  console.log(sql);
  // console.log(results.token_id);
});

//BARU! get trip_id from schedule with parameter : stop_id & time _arrival
// app.get("/api/schedule/stop-time/:stop_id/:current_time", (req, res) => {
app.post("/api/schedule/stop-time/", (req, res) => {
  let sql =
    "SELECT trip_id, time_arrival from daily_schedules where time_arrival >= '" + req.body.current_time + "' and stop_id = " + req.body.stop_id + " order by time_arrival asc limit 1 ";
  let query = conn.query(sql, (err, results) => {
    if (err) throw err;
    res.json(results);
  });
  console.log(sql);
  // console.log(results.token_id);
});



// update dailyschedule
app.put("/api/schedule/update/", (req, res) => {
  let sql =
    "UPDATE daily_schedules SET time_arrival = '" +
    req.body.time_arrival +
    "', updated_at='" +
    moment(Date.now()).format("YYYY-MM-DD HH:mm:ss") +
    "'WHERE trip_id=" +
    req.body.trip_id + 
     " AND stop_id=" +
    req.body.stop_id ;
  let query = conn.query(sql, (err, results) => {
    if (err) throw err;
    res.send(JSON.stringify({ status: 200, error: null, response: results }));
  });
});


// 5. upload data check (naik turun)
app.post("/api/commute/", (req, res) => {
  let data = {
    user_id: req.body.user_id,
    stop_name: req.body.stop_name,
    direction: req.body.direction,
    bus_code: req.body.bus_code,
    stop_id: req.body.stop_id,
    longitude: req.body.longitude,
    latitude: req.body.latitude,
    status_check: req.body.status_check,
    created_at: moment(Date.now()).format("YYYY-MM-DD HH:mm:ss")
  };
  let sql = "INSERT INTO commutes SET ?";
  let query = conn.query(sql, data, (err, results) => {
    if (err) throw err;
    res.send(JSON.stringify({ status: 200, error: null, response: results }));
  });
  console.log("request:", req);
  console.log(data);
});

//-----------------------------------------------REMINDER------------------------------------------------------------------
// 1. Add Reminder
app.post("/api/reminder/add", (req, res) => {
  let data = {
    user_id: req.body.user_id,
    title: req.body.title,
    stop_id: req.body.stop_id,
    stop_name: req.body.stop_name,
    direction: req.body.direction,
    interval_start: req.body.interval_start,
    interval_stop: req.body.interval_stop,
    time_before_arrival: req.body.time_before_arrival,
    repeats: req.body.repeats,
    is_active: 1,
    created_at: moment(Date.now()).format("YYYY-MM-DD HH:mm:ss")
  };
  let sql = "INSERT INTO reminders SET ?";
  let query = conn.query(sql, data, (err, results) => {
    if (err) throw err;
    res.send(JSON.stringify({ status: 200, error: null, response: results }));
  });
  console.log("request:", req);
  console.log(data);
});

//3. Update reminder all properties
app.put("/api/reminder/update/", (req, res) => {
  let sql =
    "UPDATE reminders SET stop_id =" +
    req.body.stop_id +
    ", stop_name =" +
    req.body.stop_name +
    ", bus_code =" +
    req.body.bus_code +
    ", direction = " +
    req.body.direction +
    ", interval_start = " +
    req.body.interval_start +
    ", interval_stop = " +
    req.body.interval_stop +
    ", time_before_arrival = " +
    req.body.time_before_arrival +
    ", repeats = " +
    req.body.repeats +
    ", is_active='" +
    req.body.is_active +
    "', updated_at='" +
    moment(Date.now()).format("YYYY-MM-DD HH:mm:ss") +
    "'WHERE id=" +
    req.body.id_reminder;
  let query = conn.query(sql, (err, results) => {
    if (err) throw err;
    res.send(JSON.stringify({ status: 200, error: null, response: results }));
  });
});

// 2. Update is_active
app.put("/api/reminder/update-active/", (req, res) => {
  let sql =
    "UPDATE reminders SET is_active='" +
    req.body.is_active +
    "', updated_at='" +
    moment(Date.now()).format("YYYY-MM-DD HH:mm:ss") +
    "'WHERE id=" +
    req.body.id_reminder;
  let query = conn.query(sql, (err, results) => {
    if (err) throw err;
    res.send(JSON.stringify({ status: 200, error: null, response: results }));
  });
});

//4. Get reminder per user
app.get("/api/reminder/user/:user_id", (req, res) => {
  let sql =
    "SELECT * from reminders where user_id = " +
    req.params.user_id +
    " order by created_at DESC";
  let query = conn.query(sql, (err, results) => {
    if (err) throw err;
    res.send(JSON.stringify({ status: 200, error: null, response: results }));
  });
  console.log(sql);
  // console.log(results.token_id);
});

//5. Get reminder per id reminder
app.get("/api/reminder/item/:reminder_id", (req, res) => {
  let sql =
    "SELECT * from reminders where id = " +
    req.params.reminder_id +
    " ";
  let query = conn.query(sql, (err, results) => {
    if (err) throw err;
    res.send(JSON.stringify({ status: 200, error: null, response: results }));
  });
  console.log(sql);
  // console.log(results.token_id);
});

//Server listening
app.listen(port, () => {
  console.log("Server running at port " + port);
});
