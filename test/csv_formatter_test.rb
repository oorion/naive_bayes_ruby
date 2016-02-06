require 'minitest/autorun'
require_relative 'test_helper'
require_relative '../csv_parser'
require_relative '../csv_formatter'

class CSVFormatterTest < MiniTest::Unit::TestCase
  def parsed_data
    CSVParser.new('./test/test_data/test_transcripts_class1.csv').parse
  end

  def test_it_can_return_all_words_in_a_specified_class_dataset
    assert_equal ["this","is","a","test","some","data","another","test","one","last","one","for", "good","measure"], CSVFormatter.new(parsed_data).all_words
  end
end
