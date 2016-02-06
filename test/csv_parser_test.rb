require 'minitest/autorun'
require_relative 'test_helper'
require_relative '../csv_parser'

class CSVParserTest < MiniTest::Unit::TestCase
  def csv_parser
    CSVParser.new('./test/test_data/test_transcripts_class1.csv')
  end

  def test_it_can_take_a_file_path
    assert csv_parser
  end

  def test_it_can_parse_a_csv_file
    parsed_data = csv_parser.parse
    
    assert_instance_of CSV::Table, parsed_data
    assert_equal 3, parsed_data.count
  end
end
