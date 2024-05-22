require 'date'
# require 'test/unit'

class TicketSearch
  def self.date_valid?(date)
    begin
      Date.parse(date)
      true
    rescue
      false
    end
  end
end

def menu
  puts "Bem Vindo à Hawks Linhas Aéreas!"
  puts "Por favor digite seu nome: "

  user_name = gets.chomp

  puts "Olá #{user_name}, estamos felizes em ver seu interesse em viajar conosco!"

  while true
    puts "Selecione uma opção do menu abaixo: "
    puts "1 - Buscar passagens \n2 - Sair"
    op = gets.chomp.to_i
    if op == 1
      puts "Para realizar a busca das passagens aéres, por favor preencha as informações abaixo: "

      puts "Qual é o aeroporto de origem? "
      route_origin = gets.chomp

      puts "Qual é o aeroporto de destino? "
      route_destiny = gets.chomp

      puts "Digite a data que deseja viajar (exemplo: 25/01/2025):"

      departure_date = gets.chomp.gsub(' ','')

      unless TicketSearch.date_valid?(departure_date)
        puts "Informação inválida. Por favor digite uma data!"
        next
      end

      puts "Digite a data de retorno (exemplo: 10/03/2025). Caso não queira pesquisar passagens "\
      "para a volta, apenas digite enter:"

      return_date = gets.chomp.gsub(' ','')
      date_valid = TicketSearch.date_valid?(return_date)

      if !date_valid && !return_date.empty?
        puts "Informação inválida. Por favor digite uma data!"
        next
      end

      puts "Os dados para busca da passagem são:
        Aeroporto de origem: #{route_origin}
        Aeroporto de destino: #{route_destiny}
        Data de Partida: #{departure_date}
        Data de Retorno: #{return_date.empty? ? "Não informado": return_date}
      "
      break
    elsif op == 2
      puts 'A Hawks linhas aéreas agradece sua presença! Até outros vôos!'
      exit
    else
      puts 'Por favor selecione uma opção válida no menu!'
    end
  end
end

if ARGF.argv.include?('--tests')
  # class TicketSearchTest < Test::Unit::TestCase
  #   def test_valid_date
  #     # typed_date = StringIO.new("one\ntwo\n")

  #     date = TicketSearch.date_valid?('09/02/1998')

  #     assert_equal(true, date)
  #   end

  #   def test_invalid_date
  #     nonexistent_date = TicketSearch.date_valid?('70/30/2024')
  #     typed_text = TicketSearch.date_valid?('Osasco')
  #     typed_number = TicketSearch.date_valid?('1234567')

  #     assert_equal(false, nonexistent_date)
  #     assert_equal(false, typed_text)
  #     assert_equal(false, typed_number)
  #   end

  #   def test_input_values
  #     name = 'Fernando'
  #     option = '1'
  #     route_origin = 'GRU'
  #     route_destiny = 'JPN'
  #     departure_date = '01/03/2025'
  #     return_date = '01/03/2026'

  #     File.write("respostas.txt", "#{name}\n#{option}\n#{route_origin}\n#{route_destiny}\n#{departure_date}\n#{return_date}")

  #     copia = File.read("ticket_search.rb").split("class TicketSearchTest").first

  #     File.write("copia.rb", copia)

  #     $stdin.reopen("respostas.txt")

  #     resultado = `ruby copia.rb`

  #     File.delete("copia.rb","respostas.txt")

  #     assert_equal(true, resultado.include?("Data de Partida: 01/03/2025"))
  #     assert_equal(true, resultado.include?("Data de Retorno: 01/03/2026"))
  #   end
  # end
  puts "Caindo no If ele tá"
  # O require do 'test/unit' tá impedindo a flag funcionar
else
  menu
end