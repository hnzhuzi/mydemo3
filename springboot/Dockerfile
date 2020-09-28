FROM openjdk:8-jre-alpine
RUN sed -i 's#dl-cdn.alpinelinux.org#mirrors.aliyun.com#g' /etc/apk/repositories; \
    apk add tzdata; \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    echo Asia/Shanghai > /etc/timezone;
    # addgroup -g 1000 user01; \
    # adduser  -u 1000 -G user01 -D user01;
# RUN apt-get update \
    # && apt-get -y install docker-ce \
    # && rm -rf /var/lib/apt/lists/*
# USER user01
# CMD和ENTRYPOINT都有shell模式和exec模式，在shell模式下，container的主进程通过sh为入口，在sh中再执行CMD/ENTRYPOINT所指定的命令，在exec模式下，container直接就执行CMD/ENTRYPOINT所指定的命令。在shell模式下，ENTRYPOINT会覆盖CMD。在exec模式下，CMD所设置的参数会成为ENTRYPOINT的参数
# CMD echo "The application will start in ${JHIPSTER_SLEEP}s..." && \
#     sleep ${JHIPSTER_SLEEP} && \
#     java ${JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom -jar /app.jar
# java -jar -Dspring.profiles.active=prod -Dswitch=on service-api-1.0.jar
# java -jar -Dspring.profiles.active=prod service-api-1.0.jar --switch=on
COPY target/*.jar  /app/app.jar
CMD ["sh", "-c", "java $JVMSIZE -jar  /app/app.jar --server.port=8001"]
