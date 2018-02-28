# A one button run and jump game
# 20 X 5 board
T = 0.3

AIR = '*'.freeze
OBSTACLE = '0'.freeze
GROUND = '_'.freeze
PLAYER = '@'.freeze

class Player
  attr_accessor :moving
  attr_reader :position, :avatar

  def initialize(board, avatar = PLAYER)
    @board = board
    @position = 82
    @avatar = avatar
    @moving = -1

    @board.place(@avatar, @position)
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

class Board
  def initialize
    @size = 100
    @board = 80.times.map { Tile.new(AIR) } + 20.times.map { Tile.new(GROUND) }
    @board.freeze
  end

  def [](i)
    @board[i]
  end

  def []=(i, v)
    @board[i] = v
  end

  def place(item, index)
    @board[index].content = item
  end

  def draw
    system 'clear' or system 'cls'
    @board.each_slice(20) { |tiles| puts tiles.join(' ') }
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

def jump2(board, player)
  player.moving = 0
  10.times do
    sleep(T)
    player.next
    board.draw
  end
end

def scroll(board, obstacle)
  19.times do
    sleep(T)
    board.move(obstacle.position, obstacle.scroll)
    board.draw
  end
  board[obstacle.position].content = nil
  board.draw
end

board = Board.new
player = Player.new(board)
obstacle = Obstacle.new #(board)
board.place(obstacle.avatar, obstacle.position)
board.draw
#jump(board, player)
jump2(board,player)
#scroll(board, obstacle)




def numbers
  @board.map!.with_index do |e, i|
    e == AIR ? i.to_s :  e
  end
  draw_board
end

#numbers
