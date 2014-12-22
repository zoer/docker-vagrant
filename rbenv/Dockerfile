FROM zoer/vagrant:wheezy
MAINTAINER Oleg Yashchuk <oazoer@gmail.com>

# Install deps
RUN \
  apt-get update && apt-get upgrade -y && \
  apt-get install -y build-essential libyaml-dev libxml2-dev libxslt-dev \
    build-essential git-core curl libssl-dev readline-common autoconf curl \
    zlib1g zlib1g-dev libmysqlclient-dev libcurl4-openssl-dev libxslt1-dev \
    libxml2-dev wget libtool && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


USER vagrant

# Install rbenv and ruby-build
RUN git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
RUN \
  git clone https://github.com/sstephenson/ruby-build.git \
    $HOME/.rbenv/plugins/ruby-build
RUN \
  PREFIX=/home/vagrant/bin /home/vagrant/.rbenv/plugins/ruby-build/install.sh
ENV PATH="/home/vagrant/.rbenv/bin:/home/vagrant/.rbenv/shims:$PATH"
RUN echo 'PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH' >> $HOME/.profile
RUN echo 'eval "$(rbenv init -)"' >> $HOME/.profile

# Install ruby
ENV RBENV_VERSION 2.0.0-p481
RUN \
  eval "$(rbenv init -)" && \
  rbenv install $RBENV_VERSION && \
  rbenv global $RBENV_VERSION

USER root

CMD ["/usr/sbin/sshd", "-D"]
