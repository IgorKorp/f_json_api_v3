FROM ruby:3.0
RUN apt-get update -qq && apt-get install -y nodejs
RUN gem install bundler -v 2.2.3
WORKDIR /www/app
COPY Gemfile /www/app/Gemfile
COPY Gemfile.lock /www/app/Gemfile.lock
RUN bundle update
RUN bundle install
COPY . /www/app


COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000


CMD ["rails", "server", "-b", "0.0.0.0"]