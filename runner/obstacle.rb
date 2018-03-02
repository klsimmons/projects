class Obstacle
  attr_accessor :moving
  attr_reader :position, :avatar

  def initialize(board, position = 99)
    @position = position
    @avatar = OBSTACLE
    @board = board
    @board.place(self, @position)
  end

  def to_s
    @avatar
  end

  def scroll
    @position -= 1
  end

  def next
    @board.move(@position, scroll)
  end
end
