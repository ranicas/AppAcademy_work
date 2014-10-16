require 'set'

class WordChainer
  def initialize(file_name)
    @dictionary = File.readlines(file_name).map(&:chomp)
    @dictionary = Set.new(@dictionary)
  end
  
  def adjacent_word(word)
    adjacent_words = []
    word.each_char.with_index do |old_letter, i|
      ('a'..'z').each do |letter|
        next if letter == old_letter
        
        new_word = word.dup
        new_word[i] = letter
      
        adjacent_words << new_word if @dictionary.include?(new_word)     
      end
    end
    
    adjacent_words
  end
  
  def run(source, target)
    @current_words, @all_seen_words = [source], {source => nil}
    
    until @current_words.empty? || @all_seen_words.include?(target)
      explore_words
    end

    build_path(target)
  end
  
  def explore_words(cur_word, new_current_words)
    new_current_words = []
    @current_words.each do |cur_word|
      adjacent_word(cur_word).each do |adj_word| 
        next if @all_seen_words.has_key?(adj_word)
        
        new_current_words << adj_word
        @all_seen_words[adj_word] = cur_word
      end
    end
    @current_words = new_current_words

  end
  
  def build_path(target)
    path = []   
    from_word = target
    
    until from_word.nil?
      path << from_word 
      from_word = @all_seen_words[from_word]
    end
    
    path.reverse
  end
end



word = WordChainer.new("dictionary.txt")

p word.adjacent_word("sit")
p word.run("ruby", "duck")