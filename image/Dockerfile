FROM amazoncorretto:22-jdk
RUN yum install jq udev -y && mkdir /data

COPY /docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
EXPOSE 25565 25565

STOPSIGNAL SIGINT

VOLUME ["/data"]
ENV VERSION=1.16.2\
    FORCE_UPDATE=false\
    EULA=false\
    JAVA_XMX=1024M\
    JAVA_XMS=1024M\
    JAVA_OPTIONS="-XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:G1MixedGCLiveThresholdPercent=35 -XX:+AlwaysPreTouch -XX:+ParallelRefProcEnabled -Dusing.aikars.flags=mcflags.emc.gs"

ENTRYPOINT ["/docker-entrypoint.sh"]
