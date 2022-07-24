require "pry"

class TicTacToe
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  attr_accessor :board

  def initialize
    @board = [" "] * 9
  end

  def display_board
    puts [" #{board[0]} | #{board[1]} | #{board[2]} "]
    puts "-----------"
    puts [" #{board[3]} | #{board[4]} | #{board[5]} "]
    puts "-----------"
    puts [" #{board[6]} | #{board[7]} | #{board[8]} "]
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, player)
    @board[index] = player
  end

  def position_taken?(index)
    @board[index] == "X" || @board[index] == "O"
  end

  def valid_move?(index)
    index >= 0 && index <= 8 && !position_taken?(index) ? true : false
  end

  def turn_count
    @board.filter {|index| index != " "}.count
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    print "please input a position between 1 - 9 >>"
    index = input_to_index gets.chomp
    if valid_move? index
      move(index, current_player)
      display_board
    else
      puts "Invalid move, please input a position again."
      turn
    end
  end

  def won?
    def check_win(player)
      side = @board.each_index.filter {|i| @board[i] == player}
      WIN_COMBINATIONS.each do |comb|
        # win = true
        # comb.each do |index|
        #   win = side.include? index
        #   win ? next : break
        # end
        # if win
        #   return comb
        # end
        if (comb - side).empty?
          return comb
        end
      end
      false
    end
    winner = check_win("X")
    winner ? winner : check_win("O")
  end

  def full?
    @board.filter {|i| i == " "}.count == 0 ? !won? : false
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? || won?
  end

  def winner
    if current_player == "X"
      won? ? "O" : nil
    else
      won? ? "X" : nil
    end
  end

  def play
    until over?
      turn
    end
    draw? ? (puts "Cat's Game!") : (puts "Congratulations #{winner}!")
  end

end

# binding.pry