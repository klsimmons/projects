# A one button run and jump game
# 20 X 5 board

require_relative "board.rb"
require_relative "player.rb"
require_relative "obstacle.rb"
require_relative "tile.rb"

T = 0.3

AIR = '*'.freeze
OBSTACLE = '0'.freeze
GROUND = '_'.freeze
PLAYER = '@'.freeze

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
obstacle = Obstacle.new(board,84)
player.moving = 0

6.times do |x|
  sleep(T)
  #board.board[0].content = x
  board.board.select(&:content).each do |tile|
    tile.content.next
  end
  board.draw
end

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
