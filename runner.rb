# A one button run and jump game
# 20 X 5 board
T = 0.3

AIR = "*"
OBSTACLE = "0"
GROUND = "_"

class Player
  attr_reader :position, :avatar

  def initialize(avatar = "@")
    @position = 82
    @avatar = avatar
  end

  def move_up
      @position = @position - 20
  end

  def move_down
    @position = @position + 20
  end
end

class Board
  def initialize
    @size = 100
    @board = ([Tile.new(AIR)] * 80) + ([Tile.new(GROUND)] * 20)
  end

  def place(item, index)
    @board[index] = item
  end

  def draw
    system 'clear' or system 'cls'
    @board.each_slice(20) { |tiles| puts tiles.join(" ") }
    puts ''
  end

  def replace(index)
    unless @board[index] == Player # || @board[index] == Obstacle
      @board[index] = self
    end
  end
end

class Tile
attr_accessor :content

  def initialize(type)
    @type = type
  end

  def to_s
    @content == nil ? @type : @content
  end
end

class Obstacle
  attr_reader :position, :avatar

  def initialize(position = 99)
    @position = position
    @avatar = OBSTACLE
  end

  def scroll
    until @position == 80
      @position -= 1
    end
  end
end

def jump(board, player)
  2.times do
    sleep(T)
    player.move_up
    board.place(player.avatar, player.position)
    board.replace(player.position + 20)
    board.draw
  end
  2.times do
    sleep(T)
    player.move_down
    board.place(player.avatar, player.position)
    board.replace(player.position - 20)
    board.draw
  end
end

player = Player.new
board = Board.new
board.place(player.avatar, player.position)
board.draw
jump(board, player)



def numbers
  @board.map!.with_index do |e, i|
    e == AIR ? i.to_s :  e
  end
  draw_board
end

#numbers
