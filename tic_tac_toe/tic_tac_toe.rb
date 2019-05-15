# The rules of tic-tac-toe are as follows

# There are two players in the game (X and O)
# Players take turns until the game is over
# A player can claim a field if it is not already taken
# A turn ends when a player claims a field
# A player wins if they claim all the fields in a row, column or diagonal
# A game is over if a player wins
# A game is over when all fields are taken

# TODO: computer player should only be called if player's previous move was valid - game over variable?
# computer player should probably be player 2, so initialise done by game runner, and input handled by player class?

class Tic_tac_toe_game
  attr_reader :board, :active_player, :inactive_player, :game_over
  def initialize(num_players)
    @board = [
      [' ', ' ', ' '],
      [' ', ' ', ' '],
      [' ', ' ', ' ']
    ]

    if num_players == 2
      @player_1 = Player.new(:x, 1)
      @player_2 = Player.new(:o, 2)
    elsif num_players == 1
      @player_1 = Player.new(:x, 1)
      @player_2 = Computer_player.new(:o, 2)
    else 
      return nil
    end
    @game_over = false
    @active_player = @player_1
    @inactive_player = @player_2
  end

  def input(input)
    input_arr = input.split(',')
    return invalid_input_message unless validate_input(input_arr)
    input_arr.map!{ |input_val| input_val.strip.to_i }
    move(input_arr[0], input_arr[1])
  end

  def move(row, column)
    return position_filled_message(row, column) if position_filled?(row, column)
      @board[row][column] = @active_player unless update_game_over
      switch_current_player unless update_game_over
    return game_state
  end

  def game_state
    output = "Current state of the board:\n" + board_state
    if @game_over
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

  def update_game_over
    @game_over = true if row_claimed? || column_claimed? || diagonal_claimed? || board_full?
    return @game_over
  end

  def switch_current_player
    @active_player, @inactive_player = @inactive_player, @active_player
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
  attr_reader :symbol, :number, :player_type

  def initialize(symbol, number)
    @symbol = symbol
    @number = number
    @player_type = :human
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
    @game = Tic_tac_toe_game.new(2)
    puts @game.game_state
    loop do
      puts "Enter the row and column where you want to go, separated by a comma" unless @game.game_over
      puts @game.input(gets.chomp)
    end
  end

  def single_player
    @game = Tic_tac_toe_game.new(1)
    puts @game.game_state
    loop do
      puts "Enter the row and column where you want to go, separated by a comma"
      puts @game.input(gets.chomp)
      puts @game.input(@game.active_player.move(@game.board)) if @game.active_player.player_type == :computer
    end
  end


end

class Computer_player
  attr_reader :symbol, :number, :player_type
  def initialize(symbol, number)
    @player_type = :computer
    @symbol = symbol
    @number = number
  end

  def to_s
    return @symbol.to_s
  end

  def info
    return "Computer player #{@number} (#{@symbol.to_s})"
  end

  def move(board)
    # return "0, 1"
    # return pick_move_at_random(board)
    if block_if_threatens_win(board)
      return block_if_threatens_win(board)
    else
      return pick_move_at_random(board)
    end
  end

  def block_if_threatens_win(board)
    return block_horizontal_win(board) if block_horizontal_win(board)
    return pick_move_at_random(board)
    return block_vertical_win(board) if block_vertical_win(board)
    return block_diagonal_win(board) if block_diagonal_win(board)
    return nil
  end

  def pick_move_at_random(board)
    valid_moves = []
    board.each.with_index do |row, row_index|
      row.each.with_index { |piece, column_index| valid_moves.push([row_index, column_index]) if piece == ' ' }
    end
    return valid_moves.sample.join(', ')
  end

  def block_horizontal_win(board)
    block_position = []
    board.each.with_index do |row, row_index|
      if enemy(row[1]) && not_full(row)
        block_position.push([row_index, [0]]) if enemy(row[2])
        block_position.push([row_index, [2]]) if enemy(row[0])
      end
      block_position.push
    end
    block_position[0] ? block_position.sample.join(', ') : nil
  end

  def block_vertical_win(board)
    block_position = []
    board.transpose.each.with_index do |row, row_index|
      if enemy(row[1]) && not_full(row)
        block_position.push([row_index, [0]]) if enemy(row[2])
        block_position.push([row_index, [2]]) if enemy(row[0])
      end
      block_position.push
    end
    block_position[0] ? block_position.sample.join(', ') : nil
  end

  def block_diagonal_win(board)

  end

  def enemy(position)
    position != ' ' && position != self
  end

  def not_full(row)
    row.include? ' '
  end

end

runner = Tic_tac_toe_game_runner.new
runner.run

# game = Tic_tac_toe_game.new
# puts game.move(0, 2)
# player = Computer_player.new
# puts game.input(player.move(game.board))


# game = Tic_tac_toe_game.new
# puts game.move(1,2)
# puts game.move(0,1)
# puts game.move(1,1)
# puts game.move(0,2)
# puts game.move(2,1)
# puts game.move(0,0)
# puts game.move(2,2)

# computer player needs to know
