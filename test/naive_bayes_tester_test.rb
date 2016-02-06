require 'minitest/autorun'
require_relative 'test_helper'
require_relative '../csv_parser'
require_relative '../naive_bayes_trainer'
require_relative '../naive_bayes_tester'

class NaiveBayesTesterTest < MiniTest::Unit::TestCase
  def setup
    parsed_data1 = CSVParser.new('./test/test_data/test_transcripts_class1.csv').parse
    parsed_data2 = CSVParser.new('./test/test_data/test_transcripts_class2.csv').parse

    @trainer1 = NaiveBayesTrainer.new(primary_class_data: parsed_data1, other_class_data: parsed_data2)
    @test_data = ['simple', 'test']
  end

  def test_can_compute_probability_of_being_a_class
    tester = NaiveBayesTester.new(trainer: @trainer1, test_data: @test_data)

    assert_equal 0.11538461538461539 * 0.038461538461538464 * 0.375, tester.probability_of_being_primary_class
  end
end
