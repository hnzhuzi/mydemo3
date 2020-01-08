FROM harbor.k8s.maimaiti.site/library/openjdk:8-jre-alpine
VOLUME /tmp
ADD target/*.jar  /app.jar
EXPOSE 8080
ENV JAVA_OPTS="-Xms512m -Xmx3g -Djava.security.egd=file:/dev/./urandom"
RUN sed -i 's#dl-cdn.alpinelinux.org#mirrors.aliyun.com#g' /etc/apk/repositories; \
    apk add tzdata; \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    echo Asia/Shanghai > /etc/timezone;
    # addgroup -g 1000 user01; \
    # adduser  -u 1000 -G user01 -D user01;
# USER user01
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app.jar"]
