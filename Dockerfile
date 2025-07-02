FROM tomcat:10.1-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY TN_Schemes_Web.war /usr/local/tomcat/webapps/ROOT.war
