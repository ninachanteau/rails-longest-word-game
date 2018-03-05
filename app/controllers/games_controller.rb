require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split
    if @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
      response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
      json = JSON.parse(response.read)
      if json['found']
        @result = "Congratulations! #{@word} is a valid English word!"
      else
        @result = "Sorry but #{@word} does not seem to be an English word..."
      end
    else
      @result = "Sorry but #{@word} can't be built out of #{@letters.join(", ")}."
    end
  end
end
