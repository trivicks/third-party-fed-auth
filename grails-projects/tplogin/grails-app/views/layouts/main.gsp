<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

    <title>
        <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <asset:stylesheet src="application.css"/>
    <g:layoutHead/>
</head>
<body>
    <asset:javascript src="application.js"/>
    <asset:javascript src="jquery-2.2.0.min.js"/>
    <div class="footer" role="contentinfo"></div>
<br><br>
<div style="height:400px ; width:500px; border-color:#ff3366 ;border:10px ;border-style:solid; margin:auto">
    <div id="content" role="main">
        <section class="row colset-2-its">
            <h1>Welcome to Vik's App</h1>
	</div>
<br>
<br>
<br>
<center>
    <button id="authorize-button"  style="display: none; height:35px; width:200px; border:0px ; background-image: url(${assetPath(src: 'google-signin-btn.png')});"></button>
    <button id="signout-button"  style="display: none; height:35px; width:200px; border:0px ; background-image: url(${assetPath(src: 'google-signout-btn.png')});"></button>
<h1> OR </h1>
<br>
<div scope="email" class="fb-login-button" onlogin="signUpFacebookUser();" data-max-rows="1" data-size="medium" data-button-type="continue_with" data-show-faces="false" data-auto-logout-link="true" data-use-continue-as="true"></div>
<br>
<br>
    <div id="status">
    </div>
</center>
</div>

<script type="text/javascript">

//  alert('${googleClientId}' + ' / ' + '${googleAppKeyId}' + ' / ' + '${facebookAppId}');

  window.fbAsyncInit = function() {
  FB.init({
    appId      : '${facebookAppId}',
    cookie     : true,  // enable cookies to allow the server to access
                        // the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.8' // use graph api version 2.8
  });

  };

  // Load the SDK asynchronously
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "https://connect.facebook.net/en_US/all.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));


function sleep(milliseconds) {
  var start = new Date().getTime();
  for (var i = 0; i < 1e7; i++) {
    if ((new Date().getTime() - start) > milliseconds){
      break;
    }
  }
}

</script>

    <pre id="content"></pre>

    <script type="text/javascript">
      // Client ID and API key from the Developer Console
    	var CLIENT_ID = '${googleClientId}'; 
		var API_KEY = '${googleAppKeyId}';

  	// Array of API discovery doc URLs for APIs used by the quickstart
      var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/gmail/v1/rest"];

      // Authorization scopes required by the API; multiple scopes can be
      // included, separated by spaces.
      var SCOPES = 'profile'

      var authorizeButton = document.getElementById('authorize-button');
      var signoutButton = document.getElementById('signout-button');

      /**
       *  On load, called to load the auth2 library and API client library.
       */
      function handleClientLoad() {
        gapi.load('client:auth2', initClient);
      }

      /**
       *  Initializes the API client library and sets up sign-in state
       *  listeners.
       */
      function initClient() {
        gapi.client.init({
          discoveryDocs: DISCOVERY_DOCS,
          clientId: CLIENT_ID,
          apiKey: API_KEY,
          scope: SCOPES
        }).then(function () {
          // Listen for sign-in state changes.
          gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);

          // Handle the initial sign-in state.
          updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
		  var authResponse = gapi.auth2.getAuthInstance();
          //console.log('Status Token:' + authResponse.currentUser.get().getAuthResponse().id_token);
          authorizeButton.onclick = handleAuthClick;
          signoutButton.onclick = handleSignoutClick;
        });
      }

      /**
       *  Called when the signed in status changes, to update the UI
       *  appropriately. After a sign-in, the API is called.
       */
      function updateSigninStatus(isSignedIn) {
        if (isSignedIn) {
      		document.getElementById('status').innerHTML = 'You have signed in with Google account!.';
          	authorizeButton.style.display = 'none';
          	signoutButton.style.display = 'block';
		  	var authResponse = gapi.auth2.getAuthInstance();
        	var accessToken = authResponse.currentUser.get().getAuthResponse().id_token;
        	var userID = authResponse.currentUser.get().getBasicProfile().getId();
			signUpGmailUser(userID, accessToken)
        } else {
          	authorizeButton.style.display = 'block';
          	signoutButton.style.display = 'none';
      		document.getElementById('status').innerHTML = 'Please login to this app using Facebook or Google account!.';
        }
      }

      /**
       *  Sign in the user upon button click.
       */
      function handleAuthClick(event) {
        gapi.auth2.getAuthInstance().signIn();
      }

      /**
       *  Sign out the user upon button click.
       */
      function handleSignoutClick(event) {
        gapi.auth2.getAuthInstance().signOut()
			.then(function () {
      			//console.log('User signed out.');
    		});
        var sf = document.getElementById("google-signout");
	 	sf.src = "https://accounts.google.com/Logout";	
      	document.getElementById('status').innerHTML = 'Please login to this app using Facebook or Google account!.';
      }

      function appendPre(message) {
        var pre = document.getElementById('content');
        var textContent = document.createTextNode(message + '\n');
        pre.appendChild(textContent);
      }

    </script>

    <script async defer src="https://apis.google.com/js/api.js"
      onload="this.onload=function(){};handleClientLoad()"
      onreadystatechange="if (this.readyState === 'complete') this.onload()">
    </script>

    <iframe id="google-signout" width="0" height="0" frameborder="0"> </iframe>
<br>
</body>
    <g:layoutBody/>
    <div class="footer" role="contentinfo"></div>
</html>
