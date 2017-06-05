#!/bin/sh

cd ~/third-party-fed-auth/grails-projects/tplogin
nohup grails run-app -https &

cd ~/third-party-fed-auth/nodejs-projects
nohup nodejs node-firebase.js &
