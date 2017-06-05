<!doctype html>
<html>
    <head>
        <title>App Integration Info</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <asset:stylesheet src="application.css"/>
    </head>
<body>

    <asset:javascript src="application.js"/>
    <asset:javascript src="jquery-2.2.0.min.js"/>
    <div class="footer" role="contentinfo"></div>
    <div id="content" role="main">
        <section class="row colset-2-its">
            <h1>Welcome to Vik's App</h1>
	</div>
<h1> Please provide the following integration parameters for Google </h1>
<p>
These details can be obtained from your Google API Project console at https://console.developers.google.com/apis/credentials?project=(your-google-project-name)
<br>
<br>
</p>
<form action="/user/signup" method="post" name="myForm" id="myForm">
<div>
Google Client ID: 
<input name="googleClientID" type="text" value='1008947631228-2m04bnhcsngqnegqc671id3o80g6di43.apps.googleusercontent.com'></input>
(Looks like this: 123456789123-391x3tx7uvlp.apps.googleusercontent.com)
</div>
<br>
<div>
Google App Key ID: 
<input name="googleAppKeyID" type="text" value='AIzaSyB_YBlwbFQuv0swIq4QYHw9UsPwfaBZSWs'></input>
(Looks like this: kUkTcEyLgOIYF0jSaH-EMBVO-e-jAbRVYNU_Rq4Y)
</div>
<br>
<div>
Facebook App ID: 
<input name="facebookAppID" type="text" value='1875239129382484'></input>
(Defaulted to vik-app in FB, looks like this: '1875239129382484')
</div>
<center>
<input type="submit"></input>
</center>
</form>
</body>
    <div class="footer" role="contentinfo"></div>
</html>
