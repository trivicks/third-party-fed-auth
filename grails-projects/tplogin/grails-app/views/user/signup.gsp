<!doctype html>
<html>
    <head>
        <title>User Signup</title>
        <meta name="layout" content="main">
    </head>
<body>

<script>

function signUpFacebookUser() {
	
    FB.getLoginStatus(function(response) {
    	if (response.status === 'connected') {
   	   		var userID = response.authResponse.userID;
      		var accessToken = response.authResponse.accessToken;
	  		validateTokenAndSignUp("fb", userID, accessToken);
      		document.getElementById('status').innerHTML = 'You have signed in with Facebook account!.';
    	} else {
      		document.getElementById('status').innerHTML = 'Please login to this app using Facebook or Google account!.';
    	}
    });
}

function logoutFacebookUser() {
	alert('Logout called...');
    document.getElementById('status').innerHTML = 'Please login to this app using Facebook or Google account!.';
}

function signUpGmailUser(userID, accessToken) {

	validateTokenAndSignUp("gm", userID, accessToken);
}

function validateTokenAndSignUp(ltype, id, token) {
	console.log('Token is: ' + token);

    $.ajax({
        url: "/user/validateTokenAndCreateAccount",
        type:"post",
        dataType: 'json',
        data:"creds=" + JSON.stringify({loginType:ltype, accessToken:token, userID:id}),
        success: function(data) {
            document.getElementById('status').innerHTML = data.message;
        },
		fail: function(data) {
            document.getElementById('status').innerHTML = data.message;
		}
    });
}

</script>

</body>
</html>
