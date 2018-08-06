require 'open-uri'
require 'json'


class GamesController < ApplicationController
  def new
    @letters = []
    alphabet = %w(a z e r t y u i o p q s d f g h j k l m w x c v b n)
    10.times do
      @letters << alphabet.sample.capitalize
    end
  end


  def score
    @word = params[:word].split("")
    @letters = params[:letters].downcase.split(" ")
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"


    if @word.all? { |letter| @word.count(letter) <= @letters.count(letter) }
        word_validation_json = open(url).read
        word_validation = JSON.parse(word_validation_json)
        if word_validation["found"]
          @output = "Congratulations! #{@word.join} is a valid English word!"
        else
          @output = "Sorry but #{@word.join} does not seem to be a valid English word..."
        end
    else
      @letters.map! {|letter| letter.capitalize}
      @output = "Sorry but #{@word.join} can't be built out of #{@letters.join(" ")}"
    end
  end
end
