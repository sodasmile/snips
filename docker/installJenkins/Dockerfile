FROM ubuntu/java8subversion
MAINTAINER Morten Locka "morten.locka@outlook.com"
ADD http://mirrors.jenkins-ci.org/war/1.598/jenkins.war /opt/jenkins.war
RUN chmod 644 /opt/jenkins.war
ENV JENKINS_HOME /jenkins
ENTRYPOINT ["java", "-jar", "/opt/jenkins.war"]
EXPOSE 8080
CMD [""]

