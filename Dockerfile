FROM harbor.k8s.maimaiti.site/library/openjdk:8-jre-alpine
VOLUME /tmp
ADD target/*.jar  app.jar
ENV JAVA_OPTS="-Xms512m -Xmx3g -Djava.security.egd=file:/dev/./urandom"
CMD ["java","$JAVA_OPTS","-jar","app.jar"]
