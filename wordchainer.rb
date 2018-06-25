require 'set'
require 'byebug'

class WordChainer

  ALPHABET = ("a".."z").to_a

  attr_reader :dictionary

  def initialize(dictionary = "dictionary.txt")
    contents = File.readlines(dictionary).map(&:chomp)
    @dictionary = Set.new(contents)

  end

  def run(word, target_word)
    @current_words = [word]
    @all_seen_words = {word => nil}
    until @current_words.empty?
      new_current_words = explore_current_words
      @current_words = new_current_words
    end
    p build_path(target_word)
  end

  def explore_current_words
    new_current_words = []
    @current_words.each do |word|
      adjacent_words(word).each do |adj_word|
        unless @all_seen_words.include?(adj_word)
          new_current_words << adj_word
          @all_seen_words[adj_word] = word
        end
      end
    end
    new_current_words
  end

  def build_path(target)
    path = []
    current_word = target
    previous_word = @all_seen_words[target]
    while current_word
      path << current_word
      current_word, previous_word = previous_word, @all_seen_words[previous_word]
    end
    path.reverse
  end

  def adjacent_words(word)
    result = []
    ALPHABET.each do |letter|
      word.length.times do |idx|
        new_word = word[0...idx] + letter + word[idx+1..-1]
        result << new_word if dictionary.include?(new_word) && word != new_word
      end
    end
    result
  end
end

w = WordChainer.new("dictionary.txt")
w.run("duck", "ruby")
