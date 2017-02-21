############################################################
# CentOS 7 with a ORACLE-Server-JRE installation
#
# is based on the idea of Peter Rossbach
# http://www.infrabricks.de/blog/2014/12/19/docker-microservice-basis-mit-apache-tomcat-implementieren/
############################################################

FROM centos:7
MAINTAINER 21plus2

############################################################
# Configure Java Version
############################################################

ENV JAVA_VERSION_MAJOR 8
ENV JAVA_VERSION_MINOR 121
ENV JAVA_VERSION_BUILD 13
ENV JAVA_PACKAGE       server-jre
ENV JAVA_CHECKSUM      42b04aeb39aeec7ba1d0ce907b2d7f56

############################################################
# Download, verify and extract Java
############################################################

RUN curl -kLOH "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
  && echo "${JAVA_CHECKSUM}  ${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz" > ${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz.md5.txt \
  && md5sum -c ${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz.md5.txt \
  && gunzip ${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
  && tar -xf ${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar -C /opt \
  && rm ${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar* \
  && ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jdk

############################################################
# Set environment
############################################################

ENV JAVA_HOME /opt/jdk
ENV PATH ${PATH}:${JAVA_HOME}/bin

VOLUME [ "/opt/jdk"]

ENTRYPOINT ["java"]
CMD ["-version"]
