FROM tomcat:10.1-jdk17

# Remove default webapps to avoid conflicts
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file into Tomcat
COPY TN_Schemes_Web.war /usr/local/tomcat/webapps/ROOT.war
