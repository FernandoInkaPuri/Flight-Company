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

def date_valid?(date)
  begin
    Date.parse(date)
    true
  rescue
    false
  end
end

while true
  puts "Digite a data que deseja viajar (exemplo: 25/01/2025):"

  departure_date = gets.chomp.gsub(' ','')

  if date_valid?(departure_date)
    break
  else
    puts "Informação inválida. Por favor digite uma data!"
  end
end

while true
  puts "Digite a data de retorno (exemplo: 10/03/2025). Caso não queira pesquisar passagens "\
  "para a volta, apenas digite enter:"

  return_date = gets.chomp.gsub(' ','')
  break if return_date.empty?

  if date_valid?(return_date)
    break
  else
    puts "Informação inválida. Por favor digite uma data!"
  end
end

puts "Os dados para busca da passagem são:
  Aeroporto de origem: #{route_origin}
  Aeroporto de destino: #{route_destiny}
  Data de Partida: #{departure_date}
  Data de Retorno: #{return_date.empty? ? "Não informado": return_date}
"
