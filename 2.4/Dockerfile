FROM alpine:3.3

ENV RUBY_BUILD_DEPS 'git ruby build-base autoconf bison linux-headers openssl-dev readline-dev'

ENV RUBY_FULL_VERSION 2.4.0-dev
ENV RUBY_VERSION 2.4.0

ENV PATH /usr/lib/ruby/$RUBY_VERSION/bin:$PATH

RUN apk update && \
    apk add $RUBY_BUILD_DEPS bash && \
    cd /tmp && \
      git clone https://github.com/rbenv/ruby-build.git && \
      cd ruby-build && ./install.sh && \
    env RUBY_CONFIGURE_OPTS=--disable-install-doc \
        ruby-build $RUBY_FULL_VERSION /usr && \
    echo gem: --no-document >> $HOME/.gemrc && \
    gem install bundler && \
    apk del $RUBY_BUILD_DEPS && \
    rm -rf /var/cache/apk/* /tmp/*

CMD ["irb"]
