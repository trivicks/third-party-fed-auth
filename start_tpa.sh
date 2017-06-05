#!/bin/sh

cd ~/grails-projects/tplogin
nohup grails run-app -https &

cd ~/nodejs-projects
nohup nodejs node-firebase.js &
