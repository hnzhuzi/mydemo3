FROM harbor.k8s.maimaiti.site/library/openjdk:8-jre-alpine
#设置端口
EXPOSE 8761
ADD init.sh /init.sh
ADD target/*.jar /eureka.jar
#reset shell
# RUN rm /bin/sh && ln -s /bin/bash /bin/sh
ENTRYPOINT ["/bin/sh","-c","source /init.sh"]

