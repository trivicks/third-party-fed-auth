#!/bin/sh
echo "Installing nodejs..."
apt-get install nodejs
echo "Done!"
echo "Installing nodejs packages..."
npm install body-parser
npm install firebase-admin
npm install express
echo "Done!"
