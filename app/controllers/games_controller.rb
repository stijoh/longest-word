class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << Array('A'..'Z').sample }
  end

  def score
    @calculated_time = Time.now - Time.parse(params[:time])
    @answer = params[:word]
    @letters = params[:letters]
    @valid = in_grid?(@answer, @letters)
    @word_found = in_api?(@answer) if @valid
  end

  def in_grid?(attempt, grid)
    attempt.upcase.chars.all? { |l| attempt.upcase.count(l) <= grid.count(l) }
  end

  def in_api?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    read_url = open(url).read
    word = JSON.parse(read_url)

    word['found']
end
