FROM harbor.k8s.maimaiti.site/library/openjdk:8-jre-alpine
VOLUME /tmp
ADD target/*.jar  /app.jar
EXPOSE 8080
ENV JAVA_OPTS="-Xms512m -Xmx3g -Djava.security.egd=file:/dev/./urandom"
ENV TZ=Asia/Shanghai
RUN set -eux; \
    apk add --no-cache --update tzdata; \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime; \
    echo $TZ > /etc/timezone; \
    addgroup --gid 1000 java-app; \
    adduser -S -u 1000 -g java-app -h /home/java-app/ -s /bin/sh -D java-app;
USER java-app
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app.jar"]
