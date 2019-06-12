# Logstash 6.8.0 which uses Amazon Corretto OpenJDK

FROM docker.elastic.co/logstash/logstash-oss:6.8.0

USER root

# Uninstall OpenJDK 1.8
RUN yum remove -y java-1.8.0-openjdk-devel

# Download and install Amazon Corretto OpenJDK
RUN yum update -y && yum install -y wget && \
    wget https://d3pxv6yz143wms.cloudfront.net/11.0.3.7.1/java-11-amazon-corretto-devel-11.0.3.7-1.x86_64.rpm && \
    yum install -y java-11-amazon-corretto-devel-11.0.3.7-1.x86_64.rpm && \
    rm java-11-amazon-corretto-devel-11.0.3.7-1.x86_64.rpm && \
    yum remove -y wget && \
    yum clean all

# Provide JVM configuration
ADD jvm.options config/

USER 1000

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]