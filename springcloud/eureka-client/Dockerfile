FROM harbor.k8s.maimaiti.site/library/openjdk:8-jre-alpine
VOLUME /tmp
# ADD init.sh /init.sh
COPY target/*.jar /app.jar
#reset shell
# RUN ln -sf /bin/bash /bin/sh
# ENTRYPOINT ["/bin/sh","-c","source /init.sh"]
EXPOSE 8101
CMD ["sh","-c","java ${JVM_OPTS} -jar /app.jar"]