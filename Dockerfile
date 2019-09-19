#FROM adoptopenjdk/openjdk12:alpine-jre
FROM openjdk:12-alpine
RUN apk add curl &&\
    mkdir /data

EXPOSE 25565 25565
VOLUME ["/data"]


ENTRYPOINT ["/start"]

ENV VERSION=1.14.4\
    FORCE_UPDATE=false\
    EULA=false\
    JAVA_XMX=1024M\
    JAVA_XMS=1024M\
    JAVA_OPTIONS=

COPY /start* /
RUN chmod +x /start*
