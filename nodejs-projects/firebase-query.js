var admin = require("firebase-admin");
var serviceAccount = require("/home/ubuntu/vik-firebase-tplogin.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://vik-tplogin.firebaseio.com"
});

fauth = admin.auth();
fdatabase = admin.database();

addUser();


function addUser() {
	   var usersRef = fdatabase.ref("Users");
       var userFound = false;
       uid="dUl9clCDYJcyU4kIgBc8iD3ISKs2"
		usersRef.orderByValue().on("value", function(snapshot) {
  			snapshot.forEach(function(data) {
    		console.log("Key is: " + data.key + " value is: " + data.val());
            if (data.key === uid) userFound = true;
  		});
		if(!userFound) {
			console.log("User not found, adding to database")
            var date = new Date()
            usersRef.update({
  			[uid]: {
    			created_at: date,
    			updated_at: date,
    			user_id: "zUl9clCDYJcyU4kIgBc8iD3ISKs2",
    			user_name: "Vik",
    			user_email: "vik@abc.com",
    			login_type: "fb",
    			thumbnail: "http://www.example.com/12345678/photo.png"
				}
  			});
		}
	});
}
