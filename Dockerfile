FROM ubuntu

MAINTAINER dharmi@gmail.com

RUN echo deb http://archive.ubuntu.com/ubuntu precise universe > /etc/apt/sources.list.d/universe.list
RUN apt-get update

#Install packages
RUN apt-get -y -f install --no-install-recommends openjdk-7-jdk
RUN apt-get -y install wget curl git-core nano maven
RUN apt-get -y install curl

#Install Tomcat
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

ENV TOMCAT_MAJOR 7
ENV TOMCAT_VERSION 7.0.63
ENV TOMCAT_TGZ_URL https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz

RUN set -x \
        && curl -fSL "$TOMCAT_TGZ_URL" -o tomcat.tar.gz \
        && curl -fSL "$TOMCAT_TGZ_URL.asc" -o tomcat.tar.gz.asc \
        && tar -xvf tomcat.tar.gz --strip-components=1 \
        && rm bin/*.bat \
        && rm tomcat.tar.gz*

#HTTP port
EXPOSE 8080

# create a Maven jersey artifact, package, and deploy the war on tomcat
RUN mvn archetype:generate -DarchetypeArtifactId=jersey-quickstart-webapp \
                -DarchetypeGroupId=org.glassfish.jersey.archetypes -DinteractiveMode=false \
                -DgroupId=com.example -DartifactId=jerseyapp -Dpackage=com.example \
                -DarchetypeVersion=2.19 && \
cd jerseyapp && mvn package -DskipTests && \
mv target/jerseyapp.war /usr/local/tomcat/webapps && \
rm -rf ~/jerseyapp
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]