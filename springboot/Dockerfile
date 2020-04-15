FROM harbor.k8s.maimaiti.site/library/openjdk:8-jre-alpine
VOLUME /tmp
WORKDIR /app
COPY target/*.jar  /app/app.jar
# EXPOSE 8080
# ENV JAVA_OPTS="-Xms512m -Xmx3g -Djava.security.egd=file:/dev/./urandom"
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
# CMD echo "The application will start in ${JHIPSTER_SLEEP}s..." && \
#     sleep ${JHIPSTER_SLEEP} && \
#     java ${JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom -jar /app.jar
# java -jar -Dspring.profiles.active=prod -Dswitch=on service-api-1.0.jar
# java -jar -Dspring.profiles.active=prod service-api-1.0.jar --switch=on
CMD ["sh", "-c", "java $JVMSIZE -jar  /app/app.jar --server.port=8001"]
