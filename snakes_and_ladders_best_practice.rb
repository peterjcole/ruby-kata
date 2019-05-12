# From Codewars - highest rated solution

class SnakesLadders
  class Player
    attr_accessor :position

    def initialize(name)
      @name = name
      @position = 0
    end

    def wins
      "#{@name} Wins!"
    end

    def status
      "#{@name} is on square #{@position}"
    end
  end

  BOARD = {
     2 => 38,
     7 => 14,
     8 => 31,
    15 => 26,
    16 =>  6,
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

  def initialize
    @player_1 = Player.new("Player 1")
    @player_2 = Player.new("Player 2")
    @current_player = @player_1
    @game_over = false
  end

  def play(die1, die2)
    return game_over if @game_over

    unless validate(die1) && validate(die2)
      return TypeError, "Arguments must be integers between 1 and 6"
    end

    @current_player.position += die1 + die2

    if @current_player.position == 100
      @game_over = true
      return @current_player.wins
    elsif @current_player.position > 100
      @current_player.position = 200 - @current_player.position
    end

    if BOARD.key? @current_player.position
      @current_player.position = BOARD[@current_player.position]
    end

    message = @current_player.status

    unless die1 == die2
      switch_players
    end

    return message
  end

  private

  def game_over
    "Game over!"
  end

  def switch_players
    if @current_player == @player_1
      @current_player = @player_2
    else
      @current_player = @player_1
    end
  end

  def validate(die)
    (die.is_a? Integer) && die >= 1 && die <= 6
  end
end
