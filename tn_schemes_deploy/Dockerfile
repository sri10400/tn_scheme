FROM tomcat:10.1-jdk17

# Replace this with your WAR file name
COPY ./TN_Schemes_Web.war /usr/local/tomcat/webapps/ROOT.war

# This tells Docker how to start Tomcat
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
