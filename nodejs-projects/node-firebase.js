var https = require('https');
var bodyParser = require('body-parser');
var fs = require('fs');

var cwd = process.cwd()
var https_options = {
  key: fs.readFileSync(cwd + '/key.pem'),
  cert: fs.readFileSync(cwd + '/cert.pem')
};

var admin = require("firebase-admin");
var PORT = 8483;
var HOST = 'localhost';

var serviceAccount = require(cwd + '/firebase-service-account.json');
console.log('Json path is: ' + cwd + '/firebase-service-account.json')
var express = require('express');
var app = express();

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://vik-tpa-login.firebaseio.com'
});

fauth = admin.auth();
fdatabase = admin.database();

app.use(bodyParser.urlencoded());

app.get('/user', function (req, res) {
  res.send('Got GET request');
});
 
app.post('/user', function (req, res) {
  console.log(req.body.tpid);
  console.log(req.body.name);
  console.log(req.body.email);
  console.log(req.body.provider);
  if(req.body.email == "null") {
       res.send(400, "Mandatory parameter (email) for user creation is missing!");
	   return;
	}
  
fauth.createUser({
     email: req.body.email,
     emailVerified: false,
//     password: "secretPassword",
 //    displayName: req.body.name,
  //   photoURL: "http://www.example.com/12345678/photo.png",
     disabled: false
   })
     .then(function(userRecord) {
		handleSuccess(req, res, userRecord);
     })
     .catch(function(error) {
		handleFailure(req, res, error);
	});
});

function handleSuccess(req, res, userRecord) {
       createUser(userRecord.uid, req.body.tpid, req.body.name, req.body.email, req.body.provider, req.body.thumbnail);
       console.log("Successfully created new user in Auth system:", userRecord.uid);
       console.log("Successfully added new user in Database:", userRecord.uid);
       res.sendStatus(201);
};

function handleFailure(req, res, error) {
       console.log(error.errorInfo.code);
       if(error.errorInfo.code == "auth/email-already-exists") {
			console.log("User already exists, let's just update the existing record!");
       		var result = updateUser(req.body.email, req.body.name, req.body.thumbnail);
            if(result == "Success") {
       			res.sendStatus(200);
			} else {
       			res.sendStatus(299);
			}
		} else {
            console.log("Some other error...");
			console.log(error.errorInfo.message);
			res.send(500, error.errorInfo.message);
		}
};


app.put('/user', function (req, res) {
  res.send('Got PUT request');
});

app.delete('/user', function (req, res) {
  res.send('Got DELETE request');
});

function updateUser(email, name, link) {
	console.log("Updating existing user details...");
	fauth.getUserByEmail(email)
  		.then(function(userRecord) {
    		console.log("Successfully fetched user data:", userRecord.toJSON());
			var userRef = fdatabase.ref("Users/").child(userRecord.uid);
    		var date = new Date();
    		userRef.update({
    				updated_at: date,
    				user_name: name,
    				thumbnail: link
  			});
			return "Success";
  		})
  		.catch(function(error) {
    		console.log("Error fetching user data:", error);
			return error;
  	});
    
};

function createUser(uid, tpid, name, email, provider, link) {
   console.log("Creating a new user in Firebase DB..");
   var usersRef = fdatabase.ref("Users");
   var date = new Date()
   usersRef.update({
		[uid]: {
   			created_at: date,
   			updated_at: date,
   			user_id: tpid,
   			user_name: name,
   			user_email: email,
   			login_type: provider,
   			thumbnail: link
		}
   });
};

https.createServer(https_options, app).listen(PORT, HOST);
console.log('HTTPS Server listening on %s:%s', HOST, PORT);
