'use strict';

var User = require('../models/userModel.js');

exports.addUser = function(req, res) {
  console.log('REQ BODY:', req.body)
  // res.send({hello: 'world'});
  var newUser = new User(req.body);

  //handles null error 
   if(!newUser.user){

            res.status(400).send({ error:true, message: 'Please provide user' });

        }
else{
  
  User.addUser(newUser, function(err, user) {
    
    if (err)
      res.send(err);
    res.json(user);
  });
}
};


exports.getUserById = function(req, res) {
  Task.getUserById(req.params.userId, function(err, user) {
    if (err)
      res.send(err);
    res.json(user);
  });
};
