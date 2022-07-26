require 'pry'
class TicTacToe
  attr_accessor :board, :turns

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]


  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    @turns = []
  end

  def display_board
    puts row1 = [" #{@board[0]} " "|" " #{@board[1]} " "|" " #{@board[2]} "]
    puts separator = "-----------"
    puts row2 = [" #{@board[3]} " "|" " #{@board[4]} " "|" " #{@board[5]} "]
    puts separator
    puts row1 = [" #{@board[6]} " "|" " #{@board[7]} " "|" " #{@board[8]} "]
  end

  def input_to_index str
    index= str.to_i
    index - 1
  end

  def move spot, token = "X"
    @board.insert(spot, token)
    @board.pop
  end

  def position_taken? index
    if @board[index] == " "
      return false
    elsif @board[index] == "X"
      return true
    elsif @board[index] == "O"
      return true
    end
  end

  def valid_move? index
    if index < 0 
      return false
    elsif index > 8
      return false
    elsif @board[index] == "X"
      return false
    elsif @board[index] == "O"
      return false
    else 
      true
    end
  end

  def turn_count
    turns = @board.select { |a| (a == "X" || a == "O")}
    turns.length
  end

  def current_player 
    if turn_count.odd?
      "O"
    else
      "X"
    end
  end

  def turn
    puts "Please make your move"
    user_input = gets.chomp
    turn = input_to_index(user_input)
    if valid_move?(turn) == true
      move(turn)
      current_player()
      display_board()
    else
      puts "Please enter a valid move"
      turn()
    end
  end

  def won? 
    WIN_COMBINATIONS.find do |i|
      values = @board.values_at(*i)
      values.all?('X') || values.all?('O')
    end
  end

  def full?
    if @board.find {|i| i == " "}
      return false
    else
      return true
    end
  end

  def draw?
    if full?() && !won?()
      return true
    else
      return false
    end
  end

  def over?
    if won?() || draw?()
      return true
    else
      return false
    end
  end

  def winner
    if won?()
      if current_player() == "X"
        return "O"
      elsif current_player() == "O"
        return "X"
      end
    end
  end

  def play
    until over?() == true
      turn()
      binding.pry
    end

    if won?()
      puts "Congratulations #{winner()}!"
    elsif draw?()
      puts "Cat's Game!"
    end
  end

end