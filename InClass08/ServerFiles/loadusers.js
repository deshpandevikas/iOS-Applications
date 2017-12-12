var express = require('express');
var path = require('path');
var app = express();
var orm = require("orm");
var bodyParser = require('body-parser');
var jwt  = require('jsonwebtoken');
var mysql = require('mysql');

console.log(__dirname);

app.use(bodyParser.urlencoded({'extended':'true'}));            // parse application/x-www-form-urlencoded
//app.use(bodyParser.json());                                     // parse application/json
//app.use(bodyParser.json({ type: 'application/vnd.api+json' })); // parse application/vnd.api+json as json


app.post('/getALL',function(req,res){


  console.log(req.body);

  console.log(req.body.uname);

  console.log(req.body.pwd);


  //var par = JSON.parse(req.body)

console.log(typeof(req.body));
  //console.log(par);



orm.connect("mysql://root:root@localhost:3306/inclass08", function (err, db) {
  if (err) throw err;

    var users = db.define("Table1", {
        id      : {type:'number', unique:true, key:true},
       first_name   : String,
       last_name   : String,
       email   : String,
       gender : String,
       ip_address : String


    });

    db.sync(function(err) {
        if (err) throw err;

                users.find({ },30,["last_name", "Z"], function (err, people) {

                	if (err) throw err;

                    console.log("Users found: %d", people.length);

                    if(people.length> 0){

                      return res.json(people);


                    }
                    else{
                      return res.json({ success: false, 'message':"users does not exist"  });
                    }


                });



            });


    });


});



app.post('/getBy',function(req,res){


  console.log(req.body);

  console.log(req.body.field);

  console.log(req.body.order);


console.log(typeof(req.body));


var con = mysql.createConnection({
  host: "localhost",
  port : 3306,
  user: "root",
  password: "root",
  database : "inclass08"
});

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
  var sql = "SELECT * FROM (SELECT t.*, @rownum := @rownum + 1 AS rank FROM Table1 t, (SELECT @rownum := 0) r "
  + " ORDER by " +  req.body.field + " " + req.body.order + " ) AS sortedTable WHERE rank > ? LIMIT 50";
  //var sql = "SELECT * FROM TABLE1";
  var values = [req.body.rank];
  con.query(sql, [values], function (err, result) {
      if (err) throw err;
      console.log("Number of records fetched " + result.length);
      return res.json(result);


    });








  });






});









app.listen(1337);


