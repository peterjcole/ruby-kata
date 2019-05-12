# The rules of tic-tac-toe are as follows

# There are two players in the game (X and O)
# Players take turns until the game is over
# A player can claim a field if it is not already taken
# A turn ends when a player claims a field
# A player wins if they claim all the fields in a row, column or diagonal
# A game is over if a player wins
# A game is over when all fields are taken


class Tic_tac_toe_game
  
  def initialize
    @board = [
      [' ', ' ', ' '],
      [' ', ' ', ' '],
      [' ', ' ', ' ']
    ]

    @player_1 = Player.new(:x, 1)
    @player_2 = Player.new(:o, 2)
    @active_player = @player_1
  end

  def game_over?
    return true if row_claimed? || column_claimed? || diagonal_claimed? || board_full?
    return false
  end

  def move(row, column)
    @board[row][column] = @active_player.symbol unless game_over?
    switch_current_player
  end

  def switch_current_player
    @active_player = @active_player == @player_1 ? @player_2 : @player_1
  end

  def row_claimed?
    @board.any? { |row| row.uniq == [:x] || row.uniq == [:o] }
  end

  def column_claimed?
    @board.transpose.any? { |row| row.uniq == [:x] || row.uniq == [:o] }
  end

  def diagonal_claimed?
    false
  end

  def board_full?
    false
  end

  def board
    output = "Current state of the board:\n"
    @board.each do |row|
      row.each do |place|
        output += "[ #{place} ] "
      end
      output += "\n"
    end
    output
  end
  
end

class Player
  attr_reader :symbol, :number
  
  def initialize(symbol, nunber)
    @symbol = symbol
    @number = number
  end


  def win_message

  end

  def turn_message

  end

end

game = Tic_tac_toe_game.new
puts game.board
game.move(1,2)
puts game.board
game.move(0,1)
puts game.board
game.move(1,1)
puts game.board
game.move(0,2)
puts game.board
game.move(2,1)
puts game.board
game.move(0,0)
puts game.board
game.move(2,2)
puts game.board

