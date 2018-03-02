class Board
  attr_reader :board

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
    @board.each_slice(20) { |tiles| puts tiles.map(&:to_s).join(' ') }
    puts ''
  end

  def move(i1, i2)
    @board[i2].content = @board[i1].content
    @board[i1].content = nil
  end

  def next
    @board.select(&:content).each { |tile| tile.content.next }
  end
end
