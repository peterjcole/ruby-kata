class SnakesLadders
  def initialize
    @player_1 = 0
    @player_2 = 0
    @current_turn = 'player_1'
    @game_over = false
    @special_squares = {
      2 => 38,
      7 => 14,
      8 => 31,
      15 => 26,
      16 => 6,
      21 => 42,
      28 => 84,
      36 => 44,
      46 => 25,
      49 => 11,
      51 => 67,
      62 => 19,
      64 => 60,
      71 => 91,
      74 => 53,
      78 => 98,
      87 => 94,
      89 => 68,
      92 => 88,
      95 => 75,
      99 => 80
    }
  end
  
  def play(dice_1, dice_2)
    roll = dice_1 + dice_2
    if @current_turn == "player_1"
      move("player_1", roll, dice_1 == dice_2)
      return output("Player 1", @player_1)
    else
      move("player_2", roll, dice_1 == dice_2)
      return output("Player 2", @player_2)
    end
  end
  
  def move(player, roll, double)
    if player == "player_1"
      next_position = @player_1 + roll
      if next_position > 100
        diff = next_position - 100
        next_position = 100 - diff
      end
#       distance_from_100 = 100 - @player_1
#       next_position -= (roll - distance_from_100) if roll > distance_from_100
      next_position = @special_squares[next_position] if @special_squares[next_position] 
      @player_1 = next_position
      @current_turn = "player_2" unless double
    else
      next_position = @player_2 + roll
      if next_position > 100
        diff = next_position - 100
        next_position = 100 - diff
      end
      next_position = @special_squares[next_position] if @special_squares[next_position] 
      @player_2 = next_position
      @current_turn = 'player_1' unless double
    end
  end
  
  def output(player, square)
    if @game_over
      return  'Game over!' 
    elsif square == 100
      @game_over = true
      return "#{player} Wins!"
    else
      return "#{player} is on square #{square}"
    end
  end
  
end

game = SnakesLadders.new
puts game.play(1, 1)
puts game.play(1, 5)
puts game.play(6, 2)
puts game.play(1, 1)
puts game.play(2, 3)
puts game.play(1, 1)
puts game.play(1, 5)
puts game.play(6, 2)
puts game.play(1, 1)
puts game.play(2, 3)
puts game.play(1, 1)
puts game.play(1, 5)
puts game.play(6, 2)
puts game.play(1, 1)
puts game.play(2, 3)
puts game.play(1, 1)
puts game.play(1, 5)
puts game.play(6, 2)
puts game.play(1, 1)
puts game.play(2, 3)
puts game.play(1, 1)
puts game.play(1, 5)
puts game.play(6, 2)
puts game.play(1, 1)
puts game.play(2, 3)
puts game.play(1, 1)
puts game.play(1, 5)
puts game.play(6, 2)
puts game.play(1, 1)
puts game.play(2, 3)
puts game.play(1, 1)
puts game.play(1, 5)
puts game.play(6, 2)
puts game.play(1, 1)
puts game.play(2, 3)
puts game.play(1, 1)
puts game.play(1, 5)
puts game.play(6, 2)
puts game.play(1, 1)
puts game.play(2, 3)
puts game.play(1, 5)
puts game.play(6, 2)
puts game.play(1, 1)
puts game.play(2, 3)
puts game.play(1, 1)
puts game.play(1, 5)
puts game.play(6, 2)
puts game.play(1, 1)
puts game.play(2, 3)
puts game.play(1, 1)
puts game.play(1, 5)
puts game.play(6, 2)
puts game.play(1, 1)
puts game.play(2, 3)
puts game.play(1, 5)
puts game.play(6, 2)
puts game.play(1, 1)
puts game.play(2, 3)
puts game.play(1, 1)
puts game.play(1, 5)
puts game.play(6, 2)
puts game.play(1, 1)
puts game.play(2, 3)
puts game.play(1, 1)
puts game.play(1, 5)
puts game.play(6, 2)
puts game.play(1, 1)
puts game.play(2, 3)
puts game.play(1, 5)
puts game.play(6, 2)
puts game.play(1, 1)
puts game.play(2, 3)
puts game.play(1, 1)
puts game.play(1, 5)
puts game.play(6, 2)
puts game.play(1, 1)
puts game.play(2, 3)
puts game.play(1, 1)
puts game.play(1, 5)
puts game.play(6, 2)
puts game.play(1, 1)
puts game.play(2, 3)



# Test.assert_equals(game.play(1, 1), "Player 1 is on square 38", "Should return: 'Player 1 is on square 38'")
# Test.assert_equals(game.play(1, 5), "Player 1 is on square 44", "Should return: 'Player 1 is on square 44'")
# Test.assert_equals(game.play(6, 2), "Player 2 is on square 31", "Should return: 'Player 2 is on square 31'")
# Test.assert_equals(game.play(1, 1), "Player 1 is on square 25", "Should return: 'Player 1 is on square 25'")