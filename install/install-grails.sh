#!/bin/sh
echo "Installing skd man java and grails....."
source ~/.sdkman/bin/sdkman-init.sh
sdk install grails 3.2.10
grails -version
echo "Done!"
