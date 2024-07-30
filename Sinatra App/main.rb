require 'sinatra'
require 'sinatra/activerecord'
require './models/search.rb'
require './ticket_search'
require 'byebug'

set :database_file, "./config/database.yml"

before do
  cache_control :public, :must_revalidate, :max_age => 10
end


get '/' do
  erb :index
end

post '/search' do
  begin
    ticket_search = TicketSearch.new(params)
    @result = ticket_search.search
  rescue StandardError => e
    @error_message = e.message
  end
  erb :search
end

get '/searches' do
  @searches = Search.all

  erb :searches
end

get '/popular_destinations' do
  @most_popular_destinations = Search.most_popular_destinations

  erb :popular_destinations
end