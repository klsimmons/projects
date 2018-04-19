# A one button run and jump game
# 20 X 5 board
require 'io/console'
require_relative "board.rb"
require_relative "player.rb"
require_relative "obstacle.rb"
require_relative "tile.rb"

T = 1

AIR = '*'.freeze
OBSTACLE = 'X'.freeze
GROUND = '_'.freeze
PLAYER = '@'.freeze

def read_char
  STDIN.raw!
  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.cooked!
  exit 0 if input == "\u0003"
  return input
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

def collision
  puts "You lose"
end

def up_arrow(board, player)
  player.jumping = true if read_char == " "
end

board = Board.new
player = Player.new(board)
obstacle = Obstacle.new(board, 99)
player.moving = 0
input_loop = Thread.new do
  up_arrow(board, player) while true
end

10.times do |x|

  sleep(T)
  board.board.select(&:content).each do |tile|
   tile.content.next
  end

  board.draw
end
puts "i quit"
input_loop.kill
#board.draw
#up_arrow(board, player)


#jump(board, player)
#jump2(board,player)
#scroll(board, obstacle)


def numbers
  @board.map!.with_index do |e, i|
    e == AIR ? i.to_s :  e
  end
  draw_board
end

#numbers
