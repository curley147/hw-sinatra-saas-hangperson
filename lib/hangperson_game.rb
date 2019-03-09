class HangpersonGame
    
    
    def initialize(word)
        @word = word
        # a for the wrong_guesses and c for the guesses
        @a = []
        @c = []
        # for not displaynig (-----) every time we call word_with_guesses
        @num = 0
        @word_with = []
        @charNum = 0
    end
    attr_accessor :word ,:guesses , :wrong_guesses , :win , :lose , :play
    
    def guess(char)
       
        #check if the char is empty or non-char or nil
        if  char == '' || /[A-Za-z]/ !~ char || char == nil
            raise ArgumentError
        end
        # eliminating spaces and commas
         char = char.gsub(/[\s,]/ ,"")
        
        @charNum = char.chars.count
       
        # check the status of the char
        char.chars.each do |l|
            #check if it's correct and not repeated guess
            if @word.include?(l) && ((@c.include? l) == false)
                @c.push(l)
                
              # check if it's correct and repeated guesses or already in wrong_guesses
            elsif (@word.include?(l) && ((@c.include?(l)) == true)) || ((@a.include?(l)) == true)
                    return false
                     
               # check if it's already in wrong guesses or already in guesses
            elsif ((@a.include?(l)) == true) || ((('A'..'Z') === l)) || (((@c.include?(l) == true)))
                    return false
                     
                     
              # check if the word don't include the char and  not already in wrong_guesses
             elsif   @a.include?(l) == false && @c.include?(l) == false
                    @a.push(l)
                    
            end
        # end of each
        end
            @wrong_guesses =  @a.join.to_s
            @guesses = @c.join.to_s
        
    end
    
    def word_with_guesses
        #@word.chars = @word.chars
        if @num == 0
            @word.chars.each do |l|
                @word_with.push("-")
            end
            @num = 1
        end
        a= @word.chars
        b=@c.join.to_s
        #check if the guesses chars match the word chars then display it in word_with_guesses
        for i in 0..b.size - 1
            for j in 0..@word.size
                if b[i] == a[j]
                    @word_with[j] = a[j]
                end
            end
        end
        
       @word_with.join.to_s
    
    end
    
    def check_win_or_lose
        if word_with_guesses == @word
            :win
            elsif @wrong_guesses.chars.count >= 7
            :lose
            else
            :play
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