# docker-tomcat-jersey
Jersey app deployed on Tomcat created from Maven

The application is built with OpenJDK 7 + Tomcat 7 + Maven 3.x

# Build

	docker build -t dharmi/tomcat7 .

# Run

	docker run -d -p 8080:8080 dharmi/tomcat7