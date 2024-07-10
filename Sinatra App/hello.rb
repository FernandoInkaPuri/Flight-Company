require 'sinatra'
require 'byebug'
require 'net/http'

require 'sinatra/activerecord'

class TicketSearch
  def self.search(params)
    @route_origin = params[:route_origin]
    @route_destiny = params[:route_destiny]
    @departure_date = params[:departure_date]
    @return_date = params[:return_date]

    departure_date = Date.parse(@departure_date).strftime('%Y-%m-%d')
    return_date = Date.parse(@return_date).strftime('%Y-%m-%d')

    uri = URI("https://sky-scanner3.p.rapidapi.com/flights/search-roundtrip?fromEntityId=#{@route_origin}&toEntityId=#{@route_destiny}&departDate=#{departure_date}&returnDate=#{return_date}")
    header = {'x-rapidapi-key': ENV['RAPID_APIKEY']}

    response = Net::HTTP.get(uri, headers = header)
    # byebug
    show_flights(response)
  end

  def self.show_flights(response)
    flights = format_travel_response(response)
    puts "Voos de #{@route_origin} para #{@route_destiny} disponíveis:"

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
    flights
  end
end



get '/' do
  erb :index
end

post '/search' do
  @result = TicketSearch.search(params)
  byebug
  erb :search
end
