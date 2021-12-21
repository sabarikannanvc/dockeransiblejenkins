FROM tomcat:8
# Take the war and copy to webapps of tomcat added t212-5 bugfix branch
COPY target/*.war /usr/local/tomcat/webapps/dockeransible.war
