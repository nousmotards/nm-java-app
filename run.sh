#!/usr/bin/env bash
set -e

echo WGET_OPTIONS ${CURL_OPTIONS}
echo URL ${URL}
echo APP_NAME ${APP_NAME}
echo ENVIRONEMENT ${ENVIRONEMENT}
echo APP_NAME ${APP_NAME}
echo VERSION ${VERSION}
echo JAVA_OPTIONS ${JAVA_OPTIONS}

# Default download method
wget -O /home/nm-user/app.jar ${WGET_OPTIONS} ${URL}/${APP_NAME}/${ENVIRONEMENT}/${APP_NAME}_${VERSION}.jar
# Fallback download method
if [ $? != 0 ] ; then
    echo "Using alternative solution to download app"
fi

su - nm-user -c java ${JAVA_OPTIONS} /home/nm-user/app.jar