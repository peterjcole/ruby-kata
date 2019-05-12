# The rules of tic-tac-toe are as follows

# There are two players in the game (X and O)
# Players take turns until the game is over
# A player can claim a field if it is not already taken
# A turn ends when a player claims a field
# A player wins if they claim all the fields in a row, column or diagonal
# A game is over if a player wins
# A game is over when all fields are taken

class Tic_tac_toe_game
  attr_reader :board
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

  def input(input)
    input_arr = input.split(',')
    return invalid_input_message unless validate_input(input_arr)
    input_arr.map!{ |input_val| input_val.strip.to_i }
    move(input_arr[0], input_arr[1])
  end

  def move(row, column)
    return position_filled_message(row, column) if position_filled?(row, column)
      @board[row][column] = @active_player unless game_over?
      switch_current_player unless game_over?
    return game_state
  end

  def game_state
    output = "Current state of the board:\n" + board_state
    if game_over?
      output += game_over_message 
    else 
      output += "#{@active_player.info} goes next.\n"
    end
    output
  end

  private

  def board_state
    output = "       0     1     2  \n"
    @board.each.with_index do |row, index|
      output += "  #{index}  "
      row.each do |place|
        output += "[ #{place} ] "
      end
      output += "\n"
    end
    return output
  end

  def game_over?
    return true if row_claimed? || column_claimed? || diagonal_claimed? || board_full?
    return false
  end

  def switch_current_player
    @active_player = @active_player == @player_1 ? @player_2 : @player_1
  end

  def row_claimed?
    @board.any? { |row| row.uniq == [@player_1] || row.uniq == [@player_2] }
  end

  def column_claimed?
    @board.transpose.any? { |row| row.uniq == [@player_1] || row.uniq == [@player_2] }
  end

  def diagonal_claimed?
    center = @board[1][1]
    claimed = false
    if center != ' '
      top_left = @board[0][0]
      top_right = @board[0][2]
      bottom_left = @board[2][0]
      bottom_right = @board[2][2]

      if top_left == center
        claimed = true if bottom_right == center
      end

      if top_right == center
        claimed = true if bottom_left == center
      end
    end
    claimed
  end

  def board_full?
    @board.none? { |row| row.include?(' ') }
  end

  def position_filled?(row, column)
    @board[row][column] != ' '
  end

  def position_filled_message(row, column)
    filled_by = @board[row][column]
    return "Sorry, that position has already been filled by #{filled_by.info}"
  end

  def game_over_message
    return "Game over! #{@active_player.info} wins!" if row_claimed? || column_claimed? || diagonal_claimed?
    return "Game over! Noone wins!" if board_full?
  end

  def validate_input(arr)
    arr.length == 2 && arr.none? { |item| item.strip.to_i > 2 || item.strip.to_i < 0 }
  end

  def invalid_input_message
    return "You didn't input a valid move. Try again!"
  end
end

class Player
  attr_reader :symbol, :number

  def initialize(symbol, number)
    @symbol = symbol
    @number = number
  end

  def to_s
    return @symbol.to_s
  end

  def info
    return "Player #{@number} (#{@symbol.to_s})"
  end
end

class Tic_tac_toe_game_runner
  def initialize
    @game = Tic_tac_toe_game.new
    puts @game.game_state
  end

  def run
    loop do
      puts "Enter 1 for single player, 2 for two player"
      input = gets.chomp
      single_player if input == '1'
      two_player if input == '2'
    end

  end

  def two_player
    loop do
      puts "Enter the row and column where you want to go, separated by a comma"
      puts @game.input(gets.chomp)
    end
  end

  def single_player
    exit
  end


end

class Computer_player
  def initialize

  end

  def move(board)
    if find_good_move(board)
      find_good_move(board)
    else
      pick_move_at_random(board)
    end
  end

  def find_good_move(board)
    return block_horizontal if block_horizontal
    return block_vertical if block_vertical
    return block_diagonal if block_diagonal
    return nil
  end

  def pick_move_at_random(board)

  end

  def block_horizontal
    
  end

  def block_vertical

  end

  def block_diagonal

  end

end

runner = Tic_tac_toe_game_runner.new
runner.run



# game = Tic_tac_toe_game.new
# puts game.move(1,2)
# puts game.move(0,1)
# puts game.move(1,1)
# puts game.move(0,2)
# puts game.move(2,1)
# puts game.move(0,0)
# puts game.move(2,2)

