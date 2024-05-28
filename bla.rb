require 'date'
require 'test/unit'
require 'test/unit/assertions'
require 'test/unit/ui/console/testrunner'
require 'test/unit/ui/testrunnermediator'
require 'test/unit/ui/testrunnerutilities'

include Test::Unit::Assertions

require 'pry'

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
def testes
  def test_valid_date
    # typed_date = StringIO.new("one\ntwo\n")
    date = TicketSearch.date_valid?('09/02/1998')

    assert_equal(true, date)
  end

  # binding.pry
  suite = Test::Unit::TestSuite.new
  suite << :test_valid_date
  runner = Test::Unit::UI::Console::TestRunner.new(suite, {})
  runner.start
end

testes