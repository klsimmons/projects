class Tile
  attr_accessor :content

  def initialize(type)
    @type = type
  end

  def to_s
    @content.nil? ? @type : @content
  end
end
