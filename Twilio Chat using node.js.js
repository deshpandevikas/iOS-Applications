const http = require('http');
const express = require('express');
const session = require('express-session');
const MessagingResponse = require('twilio').twiml.MessagingResponse;

const app = express();

var bodyParser = require('body-parser')
var mysql = require('mysql');

app.use( bodyParser.json() );       // to support JSON-encoded bodies

app.use(bodyParser.urlencoded({     // to support URL-encoded bodies
  extended: true
}));

 

app.post('/sms', (req, res) => {
	const phone = req.body.From;
	const twiml = new MessagingResponse();
    var sql1 = require('promise-mysql');
	var connection1;
    var symptomDB = "";
	var countvarDB = -1;
    var pool = sql1.createPool({
    host            : "localhost",
    user            : "root",
    password        : "",
    database        : "twillio",
    connectionLimit : 100,
    multipleStatements : true
    });

    sql1.createConnection({
		host: "localhost",
		user: "root",
		password: "",
		database : "twillio"
	}).then(function (conn) {
		connection1 = conn;
		return connection1.query('select * from numbers where number="' + phone + '"');
    }).then(function (rows) {
        if(rows.length==0)
		{
		    stage=0;
        }
		else
        {
            countvarDB = rows[0].countvar;
            if(rows[0].symptom==null && rows[0].SRating==null)
            {
                stage = 1;
            }
            else if(rows[0].symptom!=null && rows[0].SRating==null)
            {
                stage = 2;
                symptomDB = rows[0].symptom;
            }
		}
    }).then(function () {
        if(stage==0 && req.body.Body == "START")
		{
            var ins = 'insert into numbers(number) values("'+ phone +'")';
            pool.query(ins);
            twiml.message('Welcome to the study');
            twiml.message('Please indicate your symptom (1)Headache, (2)Dizziness, (3)Nausea, (4)Fatigue, (5)Sadness, (0)None');
		}
        else if(req.body.Body == "START")
        {
            twiml.message('You have already subscribed for this study');
		}
        else if(stage == 1)
        {
            if(req.body.Body >= 0 && req.body.Body<=5)
            {
                if(req.body.Body == 0)
                {
                    pool.query("Delete from numbers where number =  '"+phone+"'");
                    twiml.message('Thank you and we will check with you later');
                }
                else
                {
                    var symptom = "";
                    if(req.body.Body==1)
                        symptom = "Headache";
                    else if(req.body.Body==2)
                        symptom = "Dizziness";
                    else if(req.body.Body==3)
                        symptom = "Nausea";
                    else if(req.body.Body==4)
                        symptom = "Fatigue";
                    else if(req.body.Body==5)
                        symptom = "Sadness";
                    pool.query("Update numbers set symptom = '"+symptom+"' where number = '"+phone+"'");
                    twiml.message('On a scale from 0(none) to 4(severe), how would you rate your '+symptom+' in the last 24 hours?');
                }
            }
            else
            {
                twiml.message('Please enter a number from 0 to 5');
            }
        }
        else if(stage == 2)
        {
            if(req.body.Body >= 0 && req.body.Body<=4)
            {
                if(req.body.Body== 0)
                    twiml.message('You do not have a '+symptomDB);
                else if(req.body.Body <= 2)
                    twiml.message('You have a mild '+symptomDB);
                else if(req.body.Body==3)
                    twiml.message('You have a moderate '+symptomDB);
                else if(req.body.Body==4)
                    twiml.message('You have a severe '+symptomDB);

                if(countvarDB==3)
                {
                    pool.query("Delete from numbers where number = '"+ phone +"'");
                    twiml.message('Thank you and see you soon');
                }
                else
                {
                    countvarDB = countvarDB+1;
                    pool.query("Update numbers set countvar = "+countvarDB+", symptom = "+null+" where number = '"+phone+"' ");
                    twiml.message('Please indicate your symptom (1)Headache, (2)Dizziness, (3)Nausea, (4)Fatigue, (5)Sadness, (0)None');
                }
            }
            else
            {
                twiml.message('Please enter a number from 0 to 4');
            }
        }
        else
        {
            twiml.message('You have not subscribed for our study. Please send START to enroll into our study');
        }
	}).then(function () {
	    res.writeHead(200, {'Content-Type': 'text/xml'});
        res.end(twiml.toString());
    }).catch(function (err) {
        if(connection1 && connection1.end) connection1.end();
        twiml.message('We are facing some technical issues. Please try again after some time');
        res.writeHead(200, {'Content-Type': 'text/xml'});
        res.end(twiml.toString());
    });

});

http.createServer(app).listen(1337, () => {
    console.log('Express server listening on port 1337');
});

