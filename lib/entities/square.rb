class Square
  include Tile
  
  attr_reader :clicked
  
  def initialize(row, col, game)
    @row, @col, @game = row, col, game
    @clicked = false
    @color = Gosu::Color.argb(0xff00ff00)
  end
  
  def click!
    @clicked = true
  end
    
  def draw(window)
    window.translate(Tile::Padding, Tile::Padding) do
      window.draw_quad 0, 0, @color,
                       0, InnerSize, @color,
                       InnerSize, 0, @color,
                       InnerSize, InnerSize, @color
    end
  end
    
end