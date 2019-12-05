'user strict';
var sql = require('../db_connection.js');

var User = function(user){
    this.uuid = user.uuid;
    this.token_id = user.token_id;
    this.name = user.name;
    this.created_at = new Date();
};

User.createUser = function (newUser, result) {    
        sql.query("INSERT INTO users set ?", newUser, function (err, res) {
                
                if(err) {
                    console.log("error: ", err);
                    result(err, null);
                }
                else{
                    console.log(res.insertId);
                    result(null, res.insertId);
                }
            });           
};
User.getUserById = function (userId, result) {
        sql.query("Select user from users where id = ? ", userId, function (err, res) {             
                if(err) {
                    console.log("error: ", err);
                    result(err, null);
                }
                else{
                    result(null, res);
              
                }
            });   
};
module.exports = User;