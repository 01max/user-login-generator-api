FROM ruby:2.6.5
RUN mkdir /user-login-generator-api
WORKDIR /user-login-generator-api
COPY Gemfile /user-login-generator-api/Gemfile
COPY Gemfile.lock /user-login-generator-api/Gemfile.lock
RUN gem install bundler
RUN bundle install
RUN bundle update
COPY . /user-login-generator-api