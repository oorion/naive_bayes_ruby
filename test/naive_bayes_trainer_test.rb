require 'minitest/autorun'
require_relative 'test_helper'
require_relative '../csv_parser'
require_relative '../naive_bayes_trainer'

class NaiveBayesTrainerTest < MiniTest::Unit::TestCase
  attr_reader :trainer

  def setup
    parsed_data1 = CSVParser.new('./test/test_data/test_transcripts_class1.csv').parse
    parsed_data2 = CSVParser.new('./test/test_data/test_transcripts_class2.csv').parse
    @trainer = NaiveBayesTrainer.new(primary_class_data: parsed_data1, other_class_data: parsed_data2)
  end

  def probabilities
    trainer.probabilities_of_each_word_in_primary_class
  end

  def test_takes_training_data_from_two_classes_formatted_as_CSV_Tables
    assert_instance_of CSV::Table, trainer.primary_class_data
    assert_instance_of CSV::Table, trainer.other_class_data
  end

  def test_can_compute_probability_of_class
    assert_equal 0.375, trainer.probability_of_primary_class
  end

  def test_can_compute_the_probabilities_of_each_word_in_class_including_laplace_smoothing
    assert_equal 2/26.0, probabilities['this']
    assert_equal 2/26.0, probabilities['data']
    assert_equal 2/26.0, probabilities['another']
    assert_equal 3/26.0, probabilities['test']
  end

  def test_does_not_return_zero_for_words_not_in_the_training_data
    assert_equal 1/26.0, probabilities['']
    assert_equal 1/26.0, probabilities['supercalafragalisticexpialodocious']
  end
end
