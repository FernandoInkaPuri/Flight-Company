require 'date'

puts "Bem Vindo à Hawks Linhas Aéreas!"
puts "Por favor digite seu nome: "

user_name = gets.chomp

puts "Olá #{user_name}, estamos felizes em ver seu interesse em viajar conosco!"
puts "Para realizar a busca das passagens aéres, por favor preencha as informações abaixo: "

puts "Qual é o aeroporto de origem? "
route_origin = gets.chomp

puts "Qual é o aeroporto de destino? "
route_destiny = gets.chomp

while true
  begin
    puts "Digite a data que deseja viajar (exemplo: 25/01/2025):"
    departure_date = Date.parse(gets.chomp)
    break
  rescue
    puts "Informação inválida. Por favor digite uma data!"
  end
end


while true
  begin
    puts "Digite a data de retorno: (exemplo: 10/03/2025)"
    return_date = Date.parse(gets.chomp)
    break
  rescue
    puts "Informação inválida. Por favor digite uma data!"
  end
end

puts "Os dados para busca da passagem são:
  Aeroporto de origem: #{route_origin}
  Aeroporto de destino: #{route_destiny}
  Data de Partida: #{departure_date.strftime('%d/%m/%Y')}
  Data de Retorno: #{return_date.strftime('%d/%m/%Y')}
"

# TODO validate_date method