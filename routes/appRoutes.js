'use strict';
module.exports = function(app) {
  var user = require('../controllers/userController');

  // todoList Routes
  app
    // .get(user.list_all_tasks)
    .post('/user', user.addUser);
   
  app.route('/user/:userId')
    .get(user.getUserById);
    };