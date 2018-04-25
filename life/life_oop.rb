# Conway's Game of Life, written using OOP principles
LIVE = "X"
DEAD = "0"

class Numeric
  def mod?(n)
    self % n == 0
  end
end

class Board
  def initialize(size)
    @size = size
    @board = [DEAD] * (@size ** 2)
  end

  def draw
    system 'clear' or system 'cls'
    @board.each_slice(@size) { |i| puts i.join(" ") }
    puts ''
  end

  def look_around(index)
    live_neighbors = 0

    unless index < @size
      start_index = index - (@size + 1)
      stop_index = index - (@size - 1)
      for x in start_index..stop_index
        live_neighbors += 1 if @board[x] == LIVE
      end
    end

    unless index >= (@size ** 2) - @size
      start_index = index + (@size - 1)
      stop_index = index + (@size + 1)
      for x in start_index..stop_index
        live_neighbors += 1 if @board[x] == LIVE
      end
    end

    unless index.mod?(@size)
      live_neighbors += 1 if @board[index - 1] == LIVE
    end
    unless (index + 1).mod?(@size)
      live_neighbors += 1 if @board[index + 1] == LIVE
    end
    live_neighbors
  end

  def change
    @board = @board.map.with_index do |e, i|
      case look_around(i)
      when 2
        e
      when 3
        LIVE
      else
        DEAD
      end
    end

    draw
  end

  def run(x)
    x.times do
      sleep(1)
      change
    end
  end

  def setup (*index)
    index.each do |i|
      continue if i < 0 || i > @board.length
      @board[i] = LIVE
    end
  end
end

board = Board.new(6)

board.setup(1,2,6,9,3,12)
board.draw
board.run(5)
