class Player
  attr_accessor :moving
  attr_reader :position, :avatar

  def initialize(board, avatar = PLAYER)
    @board = board
    @position = 82
    @avatar = avatar
    @moving = -1

    @board.place(self, @position)
  end

  def to_s
    @avatar
  end

  def move_up
    @position = @position - 20
  end

  def move_down
    @position = @position + 20
  end

  def next
    if [0, 1].include?(@moving)
      @board.move(@position, move_up)
      @moving += 1
    elsif [2, 3].include?(@moving)
      @board.move(@position, move_down)
      @moving += 1
    else
      @moving = -1
      # @board.move(@position, @position += 1)
    end
  end
end
