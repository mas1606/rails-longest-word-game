require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = (0..10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    sorted_letters = params[:sorted_letters]
    word = params[:word]
    existe = true
    word.each_char do |i| 
      if !sorted_letters.include?(i)
        existe = false
      end
    end
    if !existe
      @final_sentence = "Sorry but #{word} can't be built out of #{sorted_letters}>"
    else        
      url_readed = URI.open("https://wagon-dictionary.herokuapp.com/#{word}").read
      api_return = JSON.parse(url_readed)
      if !api_return["found"]
        @final_sentence = "Sorry but #{word} does not seem to be a valid English word"
      else
        @final_sentence = "Congratulations! #{word} is a valid English word"
      end
    end
  end
end
