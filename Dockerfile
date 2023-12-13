FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /Budget-App
WORKDIR /Budget-App
COPY Gemfile /Budget-App/Gemfile
COPY Gemfile.lock /Budget-App/Gemfile.lock
RUN gem install bundler:2.3.6
RUN bundle install
COPY . /Budget-App

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]