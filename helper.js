const moment = require("moment");

function formatTime(time) {
  let formatted = time.split(":");
  return { h: formatted[0], m: formatted[1], s: formatted[2] };
}

function calculateReminderTime(arrival, reminderTime) {
  let time = formatTime(arrival);
  let initialTime = moment()
    .hours(time.h)
    .minutes(time.m)
    .seconds(time.s);

  let remindTimeFull = moment(initialTime)
    .subtract(reminderTime, "minute")
    .format();

  let remindTime = moment(initialTime)
    .subtract(reminderTime, "minute")
    .format("hh:mm:ss");

  return { remindTime, remindTimeFull };
}

module.exports = { formatTime, calculateReminderTime };
