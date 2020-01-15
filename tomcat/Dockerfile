FROM harbor.k8s.maimaiti.site/library/tomcat:8-jre8-alpine
VOLUME /tmp
RUN sed -i 's#dl-cdn.alpinelinux.org#mirrors.aliyun.com#g' /etc/apk/repositories; \
    apk add tzdata; \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    echo Asia/Shanghai > /etc/timezone; \
    sed -i 's#8080#8002#g' /usr/local/tomcat/conf/server.xml; \
    rm -rf /usr/local/tomcat/webapps/*
COPY target/*.war  /usr/local/tomcat/webapps/app.war
