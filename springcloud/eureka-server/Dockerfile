FROM harbor.k8s.maimaiti.site/library/openjdk:8-jre-alpine
# ADD init.sh /init.sh
COPY target/*.jar /eureka.jar
#reset shell
# RUN ln -sf /bin/bash /bin/sh
# ENTRYPOINT ["/bin/sh","-c","source /init.sh"]
EXPOSE 8761
CMD ["sh","-c","java ${JVM_OPTS} -jar /eureka.jar"]
