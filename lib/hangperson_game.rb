class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess char
    
    raise ArgumentError if char == nil or char.empty? or not char.match (/[a-zA-Z]/)
    
    char.downcase!
    
    if @word.downcase.include? char and not @guesses.include? char
      @guesses << char
    elsif not @word.downcase.include? char and not @wrong_guesses.include? char
      @wrong_guesses << char
    else
      return false
    end
  end
  
  def word_with_guesses
    return @word.gsub(/./, '-') if @guesses.empty?

    return  @word.gsub(/[^#{@guesses}]/, '-')
  
  end
  
  def check_win_or_lose
    
    if word_with_guesses.include? "-" and wrong_guesses.length > 6
      return :lose
    elsif not word_with_guesses.include? "-"
      return :win
    else
      return :play
    end
  end
  


  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end

# h = HangpersonGame.new("abc")
# h.word("abc")
# h.guess("a")
# puts h.guesses()