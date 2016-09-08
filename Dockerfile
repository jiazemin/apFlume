FROM supermy/ap-jre

MAINTAINER James Mo

WORKDIR /tmp
RUN wget http://archive.apache.org/dist/flume/1.6.0/apache-flume-1.6.0-bin.tar.gz  \
    && tar zxvf apache-flume-1.6.0-bin.tar.gz  \
    && mkdir -p /opt/flume  \
    && cp -rf apache-flume-1.6.0-bin/*  /opt/flume/ \
    && rm  apache-flume-1.6.0-bin.tar.gz


COPY conf /var/tmp/
COPY lib/* /opt/flume/lib/

RUN sed  -i '/log4j.logger.org.apache.flume.lifecycle/a log4j.logger.org.apache.flume.interceptor = DEBUG'  /opt/flume/conf/log4j.properties


RUN cat /etc/hosts

RUN  echo "192.168.99.101 hbasemasteripc" >> /etc/hosts

EXPOSE 44444

ENV PATH /opt/flume/bin:$JAVA_HOME/bin:$PATH

COPY docker-entrypoint1.sh /docker-entrypoint.sh
RUN chmod a+x /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]