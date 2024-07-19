FROM ruby:3.2.3

WORKDIR /sinatra_app

COPY Gemfile Gemfile.lock ./

RUN bundle install

EXPOSE 4567

CMD [ "ruby", "hello.rb" ]