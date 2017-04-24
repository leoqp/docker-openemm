FROM debian:latest
RUN apt-get -y update && apt-get remove exim4

RUN apt-get install -y debconf

#RUN echo "postfix postfix/mailname string your.hostname.com" | debconf-set-selections
#RUN echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install --yes tar vim sed dpkg grep locales findutils wget aptitude ntpdate telnet mysql-client python-mysqldb net-tools wget sendmail sendmail-bin sendmail-cf libmilter1.0.1 syslog-ng logrotate syslog-ng-core python-setuptools supervisor 
RUN groupadd openemm
RUN useradd -m -g openemm -G adm -d /home/openemm -s /bin/bash -c "OpenEMM-2015" openemm

RUN mkdir -p /opt/openemm

WORKDIR /opt/openemm
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.tar.gz"
RUN tar -xvzf jdk-8u45-linux-x64.tar.gz && ln -s jdk1.8.0_45 java && rm jdk-8u45-linux-x64.tar.gz

RUN wget http://www-eu.apache.org/dist/tomcat/tomcat-8/v8.5.14/bin/apache-tomcat-8.5.14.tar.gz -O apache-tomcat-8.tar.gz 
RUN tar -xvzf apache-tomcat-8.tar.gz && rm *.tar.gz && ln -s apache-tomcat-8.?.?? tomcat
RUN chown -R openemm:openemm /opt/openemm

WORKDIR /home/openemm
RUN wget "http://downloads.sourceforge.net/project/openemm/OpenEMM%20software/OpenEMM%202015/OpenEMM-2015_R3-bin_x64.tar.gz" -O OpenEMM-2015_R3-bin_x64.tar.gz
RUN tar xzvpf OpenEMM-2015_R3-bin_x64.tar.gz && rm OpenEMM-2015_R3-bin_x64.tar.gz
RUN mkdir -p /usr/share/doc/OpenEMM-2015
RUN mv USR_SHARE/* /usr/share/doc/OpenEMM-2015 && rm -r USR_SHARE

RUN touch .NOT_CONFIGURED

#RUN truncate -s0 /var/log/mail.log
RUN sed -i -E 's/^(\s*)system\(\);/\1unix-stream("\/dev\/log");/' /etc/syslog-ng/syslog-ng.conf

COPY run.sh /run.sh
COPY setup-cron.sh /setup-cron.sh
COPY start-cron.sh /start-cron.sh
COPY setup-openemm.sh /setup-openemm.sh
COPY files/sendmail.mc /etc/mail/sendmail.mc


COPY supervisord.conf /etc/supervisord.conf

VOLUME ["/home/openemm"]

EXPOSE 8080 25
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
