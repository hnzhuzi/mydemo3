FROM harbor.k8s.maimaiti.site/library/openjdk:8-jre
#设置端口
EXPOSE 8761
# ADD init.sh /init.sh
ADD target/*.jar /eureka.jar
#reset shell
RUN ln -sf /bin/bash /bin/sh
# ENTRYPOINT ["/bin/sh","-c","source /init.sh"]
ENTRYPOINT ["/bin/sh","-c","java -jar /eureka.jar"]

