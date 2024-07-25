require 'sinatra'
require 'byebug'
require 'net/http'

require 'sinatra/activerecord'
require './models/search.rb'
set :database_file, "./config/database.yml"
# set :show_exceptions, :after_handler

before do
  cache_control :public, :must_revalidate, :max_age => 10
end

# class CustomError < Exception
# end

class TicketSearch
  def self.date_valid?(date)
    begin
      Date.parse(date)
      true
    rescue
      false
    end
  end

  def self.search(params)
    @route_origin = params[:route_origin]
    @route_destiny = params[:route_destiny]
    @departure_date = params[:departure_date]
    @return_date = params[:return_date]

    unless TicketSearch.date_valid?(@departure_date)
      raise StandardError, 'Por favor, informe uma data válida no campo data de partida!'
    end

    return_date_valid = TicketSearch.date_valid?(@return_date)

    if !return_date_valid && !@return_date.empty?
      raise StandardError, 'Por favor, informe uma data válida no campo data de retorno!'
    end

    if @return_date.empty?
      one_way_search_travel
    else
      roundtrip_search_travel
    end
  end

  def self.one_way_search_travel
    departure_date = Date.parse(@departure_date).strftime('%Y-%m-%d')

    uri = URI("https://sky-scanner3.p.rapidapi.com/flights/search-one-way?fromEntityId=#{@route_origin}&toEntityId=#{@route_destiny}&departDate=#{departure_date}")
    header = {'x-rapidapi-key': ENV['RAPID_APIKEY']}

    response = Net::HTTP.get(uri, headers = header)
    show_flights(response)
  end

  def self.roundtrip_search_travel
    departure_date = Date.parse(@departure_date).strftime('%Y-%m-%d')
    return_date = Date.parse(@return_date).strftime('%Y-%m-%d')

    uri = URI("https://sky-scanner3.p.rapidapi.com/flights/search-roundtrip?fromEntityId=#{@route_origin}&toEntityId=#{@route_destiny}&departDate=#{departure_date}&returnDate=#{return_date}")
    header = {'x-rapidapi-key': ENV['RAPID_APIKEY']}

    response = Net::HTTP.get(uri, headers = header)

    show_flights(response)
  end


  def self.show_flights(response)
    flights = format_travel_response(response)

    save_search(@route_origin, @route_destiny, @departure_date, @return_date)

    if @return_date.empty?
      flights[:one_way]
    else
      flights[:roundtrip][:departure]
      .zip(flights[:roundtrip][:return])
    end
  end

  def self.format_travel_response(response)
    json = JSON.parse(response)

    flights = { one_way: [], roundtrip: { departure: [], return: [] } }
    puts json

    if json.include?('errors')
      raise StandardError, 'Por favor informe um aeroporto de partida válido!' if json['errors'].include?('fromEntityId')
      raise StandardError, 'Por favor informe um aeroporto de destino válido!' if json['errors'].include?('toEntityId')
    end

    if json['data']&.has_key?('itineraries')
      json['data']['itineraries'].each do |itinerary|
        price = itinerary['price']['formatted']

        itinerary['legs'].each_with_index do |leg, index|
          company_name = leg['carriers']['marketing'].first['name']
          departure_time = Time.new(leg['departure']).strftime('%H:%M')
          arrival_time = Time.new(leg['arrival']).strftime('%H:%M')

          if itinerary['legs'].size == 1
            flights[:one_way] << "Empresa #{company_name}, horário de partida: #{departure_time}, previsão de chegada: #{arrival_time}, preço: #{price}"
          elsif index == 0
            flights[:roundtrip][:departure] << "Empresa #{company_name}, horário de partida: #{departure_time}, previsão de chegada: #{arrival_time} "
          elsif index == 1
            flights[:roundtrip][:return] << "Empresa #{company_name}, horário de partida: #{departure_time}, previsão de chegada: #{arrival_time}, preço total da viagem: #{price}"
          end
        end
      end
    end
    flights
  end

  def self.save_search(route_origin, route_destiny, departure_date, return_date)
    Search.create(
      route_origin: route_origin,
      route_destiny: route_destiny,
      departure_date: departure_date,
      return_date: return_date)
  end

  def self.most_popular_destinations
    Search.group(:route_destiny).count.sort_by {|key, value| value }.reverse
  end
end

get '/' do
  erb :index
end

post '/search' do
  begin
    @result = TicketSearch.search(params)
  rescue StandardError => e
    @error_message = e.message
  end
  erb :search
end

get '/searches' do
  @searches = Search.all

  @most_popular_destinations = TicketSearch.most_popular_destinations

  erb :show
end