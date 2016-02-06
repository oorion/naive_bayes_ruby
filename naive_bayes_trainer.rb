require_relative 'csv_formatter'

class NaiveBayesTrainer
  attr_reader :primary_class_data, :other_class_data

  def initialize(primary_class_data:, other_class_data:)
    @primary_class_data = primary_class_data
    @other_class_data = other_class_data
  end

  def probability_of_primary_class
    primary_class_data.count.to_f / (primary_class_data.count + other_class_data.count)
  end

  def probabilities_of_each_word_in_primary_class
    word_count_per_word_for_primary_class.inject(Hash.new(default_probability_for_unknown_words)) do |hash, word_and_count|
      word = word_and_count.first
      count = word_and_count.last

      # the "+ 1" and "+ primary_class_vocabulary_size" are used for laplace smoothing
      # this ensures that the probability of a document being a specific class is never
      # set to zero in the case where a word in the test document doesn't appear in the training set
      word_probability =  (count.to_f + 1) / (count_of_all_words_in_primary_class + primary_class_vocabulary_size)
      hash[word] = word_probability
      hash
    end
  end

  private

  def word_count_per_word_for_class(class_data)
    all_words_in_class(class_data).inject(Hash.new(0)) do |hash, val|
      hash[val] += 1
      hash
    end
  end

  def count_of_all_words(class_data)
    all_words_in_class(class_data).count
  end

  def all_words_in_class(class_data)
    CSVFormatter.new(class_data).all_words
  end

  def count_of_all_words_in_primary_class
    all_words_in_class(primary_class_data).count
  end

  def primary_class_vocabulary_size
    word_count_per_word_for_class(primary_class_data).size
  end

  def default_probability_for_unknown_words
    1.0 / (count_of_all_words_in_primary_class + primary_class_vocabulary_size)
  end

  def word_count_per_word_for_primary_class
    word_count_per_word_for_class(primary_class_data)
  end
end

