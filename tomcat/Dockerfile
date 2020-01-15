FROM harbor.k8s.maimaiti.site/library/tomcat:8-jre8-alpine
VOLUME /tmp
# EXPOSE 8080
# ENV JAVA_OPTS="-Xms512m -Xmx3g -Djava.security.egd=file:/dev/./urandom"
RUN sed -i 's#dl-cdn.alpinelinux.org#mirrors.aliyun.com#g' /etc/apk/repositories; \
    apk add tzdata; \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    echo Asia/Shanghai > /etc/timezone; \
    sed -i 's#8080#8002#g' /usr/local/tomcat/conf/server.xml; \
    rm -rf /usr/local/tomcat/webapps/*
    # addgroup -g 1000 user01; \
    # adduser  -u 1000 -G user01 -D user01;
COPY target/*.war  /usr/local/tomcat/webapps/app.war
# USER user01
# ENTRYPOINT ["sh", "-c", "java $JVMSIZE -jar /app.jar"]
