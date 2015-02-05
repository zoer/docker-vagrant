# http://github.com/zoer/docker-images
# docker pull zoer/vagrant-debian:wheezy
FROM debian:wheezy
MAINTAINER Oleg Yashchuk <oazoer@gmail.com>

# Common
COPY files/sources.list /etc/apt/sources.list
RUN \
  apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && \
  apt-get install --no-install-recommends -y sudo openssh-server \
    build-essential libwww-perl git-core htop mc vim tree libmagickwand-dev \
    imagemagick libmagickcore-dev chkconfig sudo libxslt1-dev libxml2-dev \
    git wget libfreetype6 libfontconfig bzip2 dnsutils \
    wget libtool libyaml-dev curl mc openssl && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# SSH
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
RUN echo 'UseDNS no' >> /etc/ssh/sshd_config

# Remove the policy file once we're finished installing software.
# This allows invoke-rc.d and friends to work as expected.
RUN rm /usr/sbin/policy-rc.d

# Add the Vagrant user and necessary passwords.
RUN \
  groupadd vagrant && \
  useradd -u 1000 -c "Vagrant" -g vagrant -d /home/vagrant \
    -m -s /bin/bash vagrant
RUN echo 'root:vagrant' | chpasswd
RUN echo 'vagrant:vagrant' | chpasswd

# Allow the vagrant user to use sudo without a password.
RUN echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant

# Install Vagrant's insecure public key so provisioning and 'vagrant ssh' work.
RUN mkdir /home/vagrant/.ssh
ADD \
  https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub \
    /home/vagrant/.ssh/authorized_keys
RUN chmod 0600 /home/vagrant/.ssh/authorized_keys
RUN chown -R vagrant:vagrant /home/vagrant/.ssh
RUN chmod 0700 /home/vagrant/.ssh


# Install PhantomJS
ENV PHANTOMJS_VERSION 1.9.7

RUN \
  mkdir -p /opt && \
  wget -q --no-check-certificate -O /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  tar -xjf /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 -C /tmp && \
  rm -f /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  mv /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/ /opt/phantomjs && \
  ln -s /opt/phantomjs/bin/phantomjs /usr/bin/phantomjs

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
