require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
      @letters << (65 + rand(26)).chr
    end
  end

  def score
    @word = params["word"]
    @results = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@word}").read)
    @letters = params["letter_array"].split(" ")
    @included = true
    @word.upcase.split("").each do |char|
      if @letters.include?(char)
        @letters.delete_at(@letters.index(char))
      else
        @included = false
      end
    end
    @score = true if @included && @results["found"] == true
  end
end
