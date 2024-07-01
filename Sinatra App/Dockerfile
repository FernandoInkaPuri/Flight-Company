FROM ruby:3.2
WORKDIR /app
COPY . /app
RUN gem install sinatra rackup puma
EXPOSE 4567

CMD [ "ruby", "hello.rb" ]