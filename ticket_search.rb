puts "Bem Vindo à Hawks Linhas Aéreas!"
puts "Por favor digite seu nome: "

user_name = gets.chomp

puts "Olá #{user_name}, estamos felizes em ver seu interesse em viajar conosco!"
puts "Para realizar a busca das passagens aéres, por favor preencha as informações abaixo: "

puts "Qual é o aeroporto de origem? "
route_origin = gets.chomp

puts "Qual é o aeroporto de destino? "
route_destiny = gets.chomp

puts "Qual a data que deseja partir? "
departure_date = gets.chomp


puts "Qual será a data de retorno? "
return_date = gets.chomp

puts "Os dados para busca da passagem são:
  Aeroporto de origem: #{route_origin}
  Aeroporto de destino: #{route_destiny}
  Data de Partida: #{departure_date}
  Data de Retorno: #{return_date}
"

