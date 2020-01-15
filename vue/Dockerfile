FROM harbor.k8s.maimaiti.site/library/nginx:alpine
# VOLUME /tmp
# EXPOSE 8080
# ENV JAVA_OPTS="-Xms512m -Xmx3g -Djava.security.egd=file:/dev/./urandom"
RUN sed -i 's#dl-cdn.alpinelinux.org#mirrors.aliyun.com#g' /etc/apk/repositories; \
    apk add tzdata; \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    echo Asia/Shanghai > /etc/timezone; \
    sed -i 's#80#8003#g' /etc/nginx/conf.d/default.conf; \
    rm -rf /usr/share/nginx/html/*
    # addgroup -g 1000 user01; \
    # adduser  -u 1000 -G user01 -D user01;
# USER user01
ADD dist/*  /usr/share/nginx/html/
