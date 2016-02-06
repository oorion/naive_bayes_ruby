require 'csv'
require 'pry'

binding.pry
true_transcripts_csv = File.open('./true_transcripts.csv', 'r')
false_transcripts_csv = File.open('./false_transcripts.csv', 'r')

true_transcripts = CSV.parse(true_transcripts_csv, headers: true)
false_transcripts = CSV.parse(false_transcripts_csv, headers: true)

# P(c) - class probabilities
total_number_of_docs = (true_transcripts.count + false_transcripts.count).to_f
probability_of_true = true_transcripts.count / total_number_of_docs
probability_of_false = false_transcripts.count / total_number_of_docs

# P(w1 | c) * P(w2 | c) ...
def all_words_in_class(class_docs)
  output = ""
  class_docs.each { |row| output += " #{row[1]}" }
  output
end

def class_word_count_hash(all_words_in_class)
  all_words_in_class.gsub!("\n", " ")
  normalized_true_words = all_words_in_class.split(/ +/)
  normalized_true_words.inject(Hash.new(0)) do |hash, val|
    hash[val] += 1
    hash
  end
end

def count_of_word_in_class(word, class_word_count_hash)
  class_word_count_hash[word]
end

def count_of_all_words_in_class(class_word_count_hash)
  class_word_count_hash.to_a.inject(0) { |sum, word_and_val| sum + word_and_val[1] }
end

# P(w1 | c) * P(w2 | c) ... for true documents
all_words_in_true_class = all_words_in_class(true_transcripts)
true_class_word_count_hash = class_word_count_hash(all_words_in_true_class)
count_of_all_words_in_true_class = count_of_all_words_in_class(true_class_word_count_hash)


true_class_word_count_hash.map do |word, count|
  count / count_of_all_words_in_true_class.to_f
end

binding.pry


def test
end


