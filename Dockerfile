FROM ubuntu
WORKDIR /app
COPY . /app
EXPOSE 8080
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk
RUN apt-get install -y maven
RUN mvn install
RUN mvn clean package
RUN tar xvf apache-tomcat-9.0.89.tar.gz -C . --strip-components=1
RUN rm apache-tomcat-9.0.89.tar.gz
RUN rm -rf webapps/*
RUN mv target/*.war webapps/ROOT.war
RUN bin/catalina.sh start
CMD ["bin/catalina.sh", "run"]
