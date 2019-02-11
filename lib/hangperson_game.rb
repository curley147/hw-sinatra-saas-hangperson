class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  # constant to holde max number of guesses
  MAX_GUESSES = 7
  #getters and setters
  attr_accessor :word , :guesses , :wrong_guesses
  #constructor
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
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
  
  def guess(letter)
    if (letter=='' || letter== NIL)
    raise ArgumentError, "Null is not allowed"
    end
	#check if input is not in the alpabet (ie. its a number)
    if (letter.match(/[^A-Za-z]/))
      raise ArgumentError, "Numbers not alllowed"
    end
	#change guessed letter to lower case
    letter=letter.downcase()
	#split word into letters
    lists=@word.split("")
	#for each letter
    lists.each do |list|
      if(letter==list)
        @wrong_guesses+=""
		#add to correct guesses list if its not there already and return true
        if(!guesses.include?letter)
          @guesses+=letter
          return true
        end
        return false
      end
    end
    @guesses+= ''
	#check if incorrect guess is in the wrong list
    if(!@wrong_guesses.include?letter)
      @wrong_guesses+=letter
      return true
    end
    return false
  end

  #method to display guessed word
  def word_with_guesses
	#variable to hold guessed word
    curr= ''
    var= 0
	#split guesses list into letters
    ges=@guesses.split("")
	#split correct word into letters
    tmps=@word.split("")
	#for each letter in correct word and each letter in guess list 
    tmps.each do |tmp|
      ges.each do |letter|
        if(tmp == letter)
		  #if correct add to display string
          curr += letter
          var = 1
        end
      end
      if (var == 0)
		#display dashes for unknown letters
        curr += '-'
      end
      var = 0
    end
    return curr
  end
  
  #method that checks guesses with correct word and counts attempts
  def check_win_or_lose
    count = 0
    tmps = @word.split("")
    comps = @guesses.split("")
    tmps.each do |tmp|
      comps.each do|comp|
      if(comp==tmp)
        count += 1
        break
      end
    end
  end
 
  if (@wrong_guesses.length == MAX_GUESSES)  # too many attempts by user
    :lose
  elsif (tmps.length == count)  # user wins
    :win
  else  #continue playing	
    :play
  end
  end
end