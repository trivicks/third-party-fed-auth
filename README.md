# third-party-fed-auth

<b>What is this application about?</b> </br>
It is a third party Oauth2 authenticator solution, meaning it allows the protected app to let its users sign up using Google or Facebook account. It is basically a single API in the backend which takes a token issued to the user/client and authenticates it with Google/Facebook. After authenticating the Token with the provider, this API fetches the user information like name, email, thumbnail etc and stores them in a Firebase Database. Before doing that it also creates a new user entry in Firebase Auth System with a new unique userID across all providers. Users who attempt to use the same email ID with different TPAs will be signed up only once, not for every TPA.

<b>Tech stack?</b> </br>
This is application is built using Grails and NodeJS. While grails stack provides the UI and the API Service, NodeJS abstracts all the transactions with Firebase APIs. For OS platform, I'd recommend a OpenSuse or Ubuntu 64-bit. IMO it whould work seamlessly on any Linux flavor. 


<h1>Setting up your environment for this project?</h1> 

<h2> Installation </h2>
After you have cloned this repo to your home directory, Please execute install commands in the following order by going into the install folder 'third-party-fed-auth/install'
./install-sdk-man.sh
source "~/.sdkman/bin/sdkman-init.sh"

Java Install details: 
openjdk version "1.8.0_131"
OpenJDK Runtime Environment (build 1.8.0_131-8u131-b11-0ubuntu1.16.04.2-b11)
OpenJDK 64-Bit Server VM (build 25.131-b11, mixed mode)

sdk install java 

Grails Install details:
| Grails Version: 3.2.10
| Groovy Version: 2.4.10
| JVM Version: 1.8.0_131

sdk install grails

Note: Alternatively, you can downlaod grails 3.2.10 from here -> https://grails.org/download.html

Install NodeJS and node modules
./install-node-modules.sh

<h2> Configuration </h2>
