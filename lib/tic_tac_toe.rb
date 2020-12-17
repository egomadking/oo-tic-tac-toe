require "Pry"

class TicTacToe

  attr_accessor :board

  WIN_COMBINATIONS = [
    [0,1,2],[3,4,5],[6,7,8],
    [0,3,6],[1,4,7],[2,5,8],
    [0,4,8],[2,4,6]]


  def initialize
    @board = Array.new(9, " ")
  end

  def display_board
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, player)
    board[index] = player
  end

  def position_taken?(index)
    !board[index].eql?(" ")
  end

  def valid_move?(index)
    index.between?(0, 8) && !self.position_taken?(index)
  end

  def turn_count
    @board.count { |i| i != " " }
  end

  def current_player
    self.turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    puts "Please enter a move 1-9: "
    choice = gets.to_i
    index = input_to_index(choice)
    valid_move?(index) ? move(index, current_player) : turn
    display_board
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      board[combo[0]] == board[combo[1]] &&
      board[combo[1]] == board[combo[2]] &&
      position_taken?(combo[0])
    end
  end

  def full?
    board.all? { |i| i != " " }
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    if won?
      board[won?[0]]
    end
  end

  def play
    turn until over?
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end