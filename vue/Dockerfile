FROM harbor.k8s.maimaiti.site/library/nginx:alpine
RUN sed -i 's#dl-cdn.alpinelinux.org#mirrors.aliyun.com#g' /etc/apk/repositories; \
    apk add tzdata; \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    echo Asia/Shanghai > /etc/timezone; \
    sed -i 's#80#8003#g' /etc/nginx/conf.d/default.conf; \
    rm -rf /usr/share/nginx/html/*;
ADD dist/*.tar.gz /usr/share/nginx/html

