FROM ruby:3.1.2

ENV PORT 3000
ENV RAILS_ROOT /var/www/app/

RUN apt-get clean
RUN apt-get autoclean
RUN apt-get install -f
RUN apt-get autoremove

RUN apt-get update
RUN curl -fsSL https://deb.nodesource.com/setup_12.x | bash -

RUN apt-get update && apt-get install -y nodejs && npm install -g yarn
RUN yarn install
RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs

RUN yarn --version
RUN node --version
RUN npm --version

RUN bundle config --global frozen 1

RUN mkdir -p $RAILS_ROOT
COPY Gemfile Gemfile.lock $RAILS_ROOT/
WORKDIR $RAILS_ROOT

RUN bundle install
ADD . $RAILS_ROOT

#RUN bundle exec rails webpacker:compile
RUN bundle exec rake assets:precompile
#RUN bundle exec rails -v
#RUN bundle exec rails webpacker:compile


EXPOSE $PORT

CMD ["bundle","exec","rails","server","-b","0.0.0.0","puma","config.ru"]
#CMD["rails","server"]
#CMD rackup
