#!/bin/sh

export SERVER_FILE=paper-${VERSION}.jar
export JAVA_COMMAND="java -Xmx${JAVA_XMX} -Xms${JAVA_XMS} ${JAVA_OPTIONS} -jar ${SERVER_FILE}"
cd /data

if [ ! -e ./eula.txt ]
then
  if "${EULA}"
  then
    echo "# Generated via Docker on $(date)" > ./eula.txt
    echo "eula=$EULA" >> ./eula.txt
    echo Generated eula.txt
  else
    echo You need to accept EULA.
    exit 2
  fi
fi

if [ ! -e ./${SERVER_FILE} ] || "${FORCE_UPDATE}"
then
    # サーバのファイルが存在しないか、FORCE_UPDATEがtrueの時　
    # reference https://docs.papermc.io/misc/downloads-api
    echo Downloading ${SERVER_FILE}
    PROJECT="paper"
    LATEST_BUILD=$(curl -s https://api.papermc.io/v2/projects/${PROJECT}/versions/${VERSION}/builds | \
    jq -r '.builds | map(select(.channel == "default") | .build) | .[-1]')
    JAR_NAME=${PROJECT}-${VERSION}-${LATEST_BUILD}.jar
    PAPERMC_URL="https://api.papermc.io/v2/projects/${PROJECT}/versions/${VERSION}/builds/${LATEST_BUILD}/downloads/${JAR_NAME}"
    curl -o ${SERVER_FILE} $PAPERMC_URL
    echo Downloaded.
else
    # サーバのファイルが存在、かつFORCE_UPDATEがfalseの時
    echo ${SERVER_FILE} already exists. Skipping download.
fi

echo -------------------------------------------------------------------------
echo Running ${JAVA_COMMAND}
echo -------------------------------------------------------------------------
exec ${JAVA_COMMAND}
