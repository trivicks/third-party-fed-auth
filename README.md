# third-party-fed-auth

<h2>What is this application about?</h2>
It is a third party Oauth2 authenticator solution, meaning it allows the protected app to let its users sign up using Google or Facebook account. 
* It is basically a single API in the backend which takes a token issued to the user/client and authenticates it with Google/Facebook. 
* After successful authentication of the Token with the provider, it creates a new user entry in Firebase Auth System with a new unique user ID ( which will be unique across all providers ). Users who attempt to use the same email ID with different TPAs will be registered  only once, not for every TPA.
* This API then fetches the user information like name, email, thumbnail etc and stores them in a Firebase Database. 

<h2>Tech stack used to build this solution</h2>
This is application is built using Grails and NodeJS. While grails stack provides the UI and the API Service, NodeJS abstracts all the transactions with Firebase APIs. For OS platform, I'd recommend a OpenSuse or Ubuntu 64-bit. IMO it whould work seamlessly on any Linux flavor. 


<h1>Setting up your environment for this project</h1> 

<h2> Installation </h2>
After you have cloned this repo to your home directory, Please execute install commands in the following order by going into the install folder 'third-party-fed-auth/install'

* ./install-sdk-man.sh

* source "~/.sdkman/bin/sdkman-init.sh"

Java Install details: 
openjdk version "1.8.0_131"
OpenJDK Runtime Environment (build 1.8.0_131-8u131-b11-0ubuntu1.16.04.2-b11)
OpenJDK 64-Bit Server VM (build 25.131-b11, mixed mode)

* sdk install java 

Grails Install details:
| Grails Version: 3.2.10
| Groovy Version: 2.4.10
| JVM Version: 1.8.0_131

* sdk install grails

Note: Alternatively, you can downlaod grails 3.2.10 from here -> https://grails.org/download.html

Install NodeJS and node modules
* ./install-node-modules.sh

<h2> Configuration </h2>
* Much of the integration parameters required to talk to Facebook and Google for Token verification are being taken in through the UI. These are:
  ** Google Client ID
  ** Google API Key
  ** Facebook APP ID

* That leaves us with only Firebase integration config. The Firebase URL is hardcoded in the firebase nodejs service file. In case you wish to use a different Firebase project, then the URL has to be edited in the JS file
* The service account JSON file is in the nodejs project folder. If the service account details change for this project, obvioulsy the new JSON has to be download from Firebase console and provided to the script
* One last thing on the NodeJS module is, since it is secure service on https, I have generated my own set of keys. These are present in the project directory as cert.pem and key.pem. For the requests from Grails service to the NodeJS to be honored, the cert.pem has to be added to the default CA keystore of the JRE version being used to run the grails project. Else all the request to NodeJS service will fail. 

<h1>Setting up your environment for this project</h1> 

<h2> Installation </h2>


