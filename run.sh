#!/usr/bin/env bash

set -e

echo URL ${URL}
echo WGET_OPTIONS \"${WGET_OPTIONS}\"
echo ENVIRONMENT ${ENVIRONMENT}
echo APP_NAME ${APP_NAME}
echo VERSION ${VERSION}
echo JAVA_OPTIONS \"${JAVA_OPTIONS:-}\"
echo AWS_ACCESS_KEY ${AWS_ACCESS_KEY}
echo AWS_SECRET_KEY ${AWS_SECRET_KEY}
echo AWS_REGION ${AWS_REGION}
echo AWS_BUCKET ${AWS_BUCKET}

WGET_COMMON_OPTIONS='-q --timeout=5 -O /home/nm-user/app.jar'
APP_COMMON_PATH="${APP_NAME}/${ENVIRONMENT}/${APP_NAME}_${VERSION}.jar"
WGET_RCODE=0

# Default download method
echo "Downloading jar..."
wget ${WGET_COMMON_OPTIONS} ${WGET_OPTIONS} ${URL}/${APP_COMMON_PATH} || WGET_RCODE=$?

# Fallback download method
if [ $WGET_RCODE != 0 ] ; then
    echo "Using alternative solution to download app"
    contentType="text/html; charset=UTF-8"
    date="`date -u +'%a, %d %b %Y %H:%M:%S GMT'`"
    resource="/${AWS_BUCKET}/${APP_COMMON_PATH}"
    string="GET\n\n${contentType}\n\nx-amz-date:${date}\n${resource}"
    signature=`echo -en $string | openssl sha1 -hmac "${AWS_SECRET_KEY}" -binary | base64`
    WGET_RCODE=0
    wget ${WGET_COMMON_OPTIONS} \
         --header "x-amz-date: ${date}" \
         --header "Content-Type: ${contentType}" \
         --header "Authorization: AWS ${AWS_ACCESS_KEY}:${signature}" \
         "https://s3-${AWS_REGION}.amazonaws.com${resource}" || WGET_RCODE=$?

    if [ $WGET_RCODE != 0 ] ; then
        echo "Can't find the required app version in any location"
        exit 1
    fi
fi

echo "Launching jar..."
su - nm-user -c "java ${JAVA_OPTIONS} -jar /home/nm-user/app.jar"