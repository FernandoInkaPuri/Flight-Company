require './flight'
require 'byebug'


class TicketSearch
  def initialize(params)
    @route_origin = params[:route_origin]
    @route_destiny = params[:route_destiny]
    @departure_date = params[:departure_date]
    @return_date = params[:return_date]
  end

  def self.date_valid?(date)
    begin
      Date.parse(date)
      true
    rescue
      false
    end
  end

  def search
    unless TicketSearch.date_valid?(@departure_date)
      raise StandardError, 'Por favor, informe uma data válida no campo data de partida!'
    end

    return_date_valid = TicketSearch.date_valid?(@return_date)

    if !return_date_valid && !@return_date.empty?
      raise StandardError, 'Por favor, informe uma data válida no campo data de retorno!'
    end

    flight = Flight.new(@route_origin, @route_destiny, @departure_date, @return_date)

    if @return_date.empty?
      flight.one_way_search_travel
    else
      flight.roundtrip_search_travel
    end
  end
end