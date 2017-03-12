#!/usr/bin/env bash
set -e
echo WGET_OPTIONS ${WGET_OPTIONS}
echo URL ${URL}
echo ENVIRONMENT ${ENVIRONMENT}
echo APP_NAME ${APP_NAME}
echo VERSION ${VERSION}
echo JAVA_OPTIONS ${JAVA_OPTIONS:-}

# Default download method
echo "Downloading jar..."
wget -q -O /home/nm-user/app.jar ${WGET_OPTIONS} ${URL}/${APP_NAME}/${ENVIRONMENT}/${APP_NAME}_${VERSION}.jar
# Fallback download method
if [ $? != 0 ] ; then
    echo "Using alternative solution to download app"
fi

echo "Launching jar..."
su - nm-user -c "java ${JAVA_OPTIONS} -jar /home/nm-user/app.jar"