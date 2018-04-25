# A program for running Conway's Game of Life

class Numeric
  def mod?(n)
    self % n == 0
  end
end

SIZE = 10

LIVE = "X"
DEAD = "0"

$board = [DEAD] * (SIZE ** 2)

def draw_board
  system 'clear' or system 'cls'
  $board.each_slice(SIZE) { |i| puts i.join(" ") }
  puts ''
end

def look_around(index)
  live_neighbors = 0

  unless index < SIZE
    start_index = index - (SIZE + 1)
    stop_index = index - (SIZE - 1)
    for x in start_index..stop_index
      live_neighbors += 1 if $board[x] == LIVE
    end
  end

  unless index >= (SIZE ** 2) - SIZE
    start_index = index + (SIZE - 1)
    stop_index = index + (SIZE + 1)
    for x in start_index..stop_index
      live_neighbors += 1 if $board[x] == LIVE
    end
  end

  unless index.mod?(SIZE)
    live_neighbors += 1 if $board[index - 1] == LIVE
  end
  unless (index + 1).mod?(SIZE)
    live_neighbors += 1 if $board[index + 1] == LIVE
  end
  live_neighbors
end

def change
  $board = $board.map.with_index do |e, i|
    case look_around(i)
    when 2
      e
    when 3
      LIVE
    else
      DEAD
    end
  end

  draw_board
end

def run(x, t = 1)
  x.times do
    sleep(t)
    change
    break if $board.include?(LIVE) == false
  end
end

def randomize
  index = []
  rand(0...SIZE**2).times {index.push(rand(0...SIZE**2)) }
  index
end

def setup(*index)
  cells = []
  index.each { |i| cells.push(i) }
  cells = randomize if cells.empty?

  cells.each do |i|
    continue if i < 0 || i > $board.length
    $board[i] = LIVE
  end
end

setup(7,13,19)
draw_board
run(5,0.5)
