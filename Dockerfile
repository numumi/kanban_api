FROM ruby:3.2.2

RUN apt-get update -qq && \
    apt-get install -y build-essential \
    nodejs \
    default-mysql-client \
    vim

ENV TZ=Asia/Tokyo

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem update --system && gem install bundler 
RUN bundle install

COPY . $APP_ROOT