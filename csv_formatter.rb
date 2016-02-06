class CSVFormatter
  attr_reader :parsed_data

  def initialize(parsed_data)
    @parsed_data = parsed_data
  end

  def all_words
    format_words(words)
  end

  private

  def words
    parsed_data.inject("") do |words, row|
      words += row['transcript'] + " "
    end
  end

  def format_words(words)
    words.gsub("\n", " ").
      split(/\W+/).
      map(&:downcase)
  end
end
