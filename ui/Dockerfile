FROM automationwizards/webtest_ruby2.3.1:xenial
MAINTAINER Automation Team

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
ADD repo-key /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa
COPY ssh_config /root/.ssh/config
RUN bundle install

RUN mkdir /app
WORKDIR /app
ADD . /app

ENV HEADLESS=true
ENV BREAKPOINTS="mobile,tablet,desktop"
ENV SERVERS="aws2"
ENV LANGUAGES="en,fr"
ENV THREADS=4
ENV TESTS="spec/web/login_spec.rb"

CMD [ "/bin/bash", "-c", "bundle exec rspec $TESTS" ]