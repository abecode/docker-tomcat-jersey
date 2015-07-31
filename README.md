# docker-tomcat-jersey
Jersey webapp created from Maven, deployed on Tomcat 7 running on OpenJDK 7 on a Debian Wheezy Linux distribution.
docker hub registry url : 

# Build

	docker build -t dharmi/tomcat7 .

# Run

	docker run -d -p 8080:8080 dharmi/tomcat7

# Test

	http://<ip-address>:8080/jerseyapp


Note: if you using boot2docker, get the ip address by running
$ boot2docker ip

# CF Diego deploy

    cf docker-push jerseyapp dharmi/tomcat7


