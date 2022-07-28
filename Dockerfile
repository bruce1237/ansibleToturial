FROM centos:latest

MAINTAINER hemantadityagangwar@gmail.com

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum install -y --nobest iproute net-tools openssh openssh-clients openssh-server
#RUN yum install -y epel-release && yum -y install ansible
RUN mkdir /root/.ssh
RUN chmod 700 /root/.ssh && chown root:root /root/.ssh
WORKDIR /root/.ssh
ADD id_rsa .
RUN chmod 600 id_rsa && chown root:root id_rsa
ADD id_rsa.pub .
RUN chmod 644 id_rsa.pub && chown root:root id_rsa.pub
RUN cp id_rsa.pub authorized_keys
RUN chmod 600 authorized_keys && chown root:root authorized_keys
WORKDIR /
EXPOSE 22


CMD ["/usr/lib/systemd/systemd"]

