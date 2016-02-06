class NaiveBayesTester
  attr_reader :trainer, :test_data

  def initialize(trainer:, test_data:)
    @trainer = trainer
    @test_data = test_data
  end

  def probability_of_being_primary_class
    test_data.inject(1) do |product, word|
      product * probabilities_of_each_word_in_primary_class[word]
    end * trainer.probability_of_primary_class
  end

  private

  def probabilities_of_each_word_in_primary_class
    @probabilities_of_each_word_in_primary_class ||= trainer.probabilities_of_each_word_in_primary_class
  end
end
