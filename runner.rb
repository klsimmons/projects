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
    @board = 80.times.map { Tile.new(AIR) } + 20.times.map { Tile.new(GROUND) }
  end

  def place(item, index)
    @board[index].content = item
  end

  def draw
    system 'clear' or system 'cls'
    @board.each_slice(20) { |tiles| puts tiles.join(" ") }
    puts ''
  end

  def move(i1, i2)
    @board[i2].content = @board[i1].content
    @board[i1].content = nil
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
    @position -= 1
  end

end

def jump(board, player)
  2.times do
    sleep(T)
    board.move(player.position, player.move_up)
    board.draw
  end
  2.times do
    sleep(T)
    board.move(player.position, player.move_down)
    board.draw
  end
end

def scroll(board, obstacle)
  19.times do
    sleep(T)
    board.move(obstacle.position, obstacle.scroll)
    board.draw
  end
  obstacle.position.content = nil
  board.draw
end

player = Player.new
board = Board.new
obstacle = Obstacle.new
board.place(obstacle.avatar, obstacle.position)
board.place(player.avatar, player.position)
board.draw
#jump(board, player)
scroll(board, obstacle)




def numbers
  @board.map!.with_index do |e, i|
    e == AIR ? i.to_s :  e
  end
  draw_board
end

#numbers
