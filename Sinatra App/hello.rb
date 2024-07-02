require 'sinatra'
require 'byebug'

class TicketSearch

end



get '/' do
  page = "
  <h1> Bem vindos à Hawks linhas aéreas! </h1>
  <h3> Por favor, preencha com as informações para a busca da passagem </h3>
  <form>
    <label> Aeroporto de partida </label><br>
    <input type='text' id='route_origin' name='route_origin'><br>
    <label> Aeroporto de Destino </label><br>
    <input type='text' id='route_destiny' name='route_destiny'><br>
    <label> Data de partida </label><br>
    <input type='text' id='departure_date' name='departure_date'><br>
    <label> Data de retorno </label><br>
    <input type='text' id='return_date' name='return_date'><br>
    <input type='submit' value='Enviar'>
  <form>
  "
  byebug
end

post '/xuxa' do
  byebug
end
