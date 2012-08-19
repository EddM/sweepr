class GameBoard
  
  attr_reader :game, :pixel_width, :pixel_height
  
  def initialize(window, difficulty)
    width, height = difficulty
    @game, @width, @height = Game.new(width, height), width, height
    @pixel_width, @pixel_height = @width * Tile::Size, @height * Tile::Size
    
    @x_offset = (window.width - @pixel_width) / 2
    @y_offset = (window.height - @pixel_height) / 2
    @x_bound = @x_offset + @pixel_width
    @y_bound = @y_offset + @pixel_height
  end
  
  def update(window)
    if window.button_down?(Gosu::MsLeft)
      mouse_x = window.mouse_x.to_i
      mouse_y = window.mouse_y.to_i
      
      if @game.active
        if mouse_x >= @x_offset && mouse_y >= @y_offset && mouse_x < @x_bound && mouse_y < @y_bound
          clicked!(mouse_x, mouse_y)
        end
      end
    end
  end
  
  def draw(window)
    window.translate(@x_offset, @y_offset) do
      draw_field(window)
      draw_tiles(window)
    end
  end
  
  private
  
  def clicked!(mouse_x, mouse_y)
    mouse_x_offset = (mouse_x - @x_offset) / Tile::Size
    mouse_y_offset = (mouse_y - @y_offset) / Tile::Size
    unless @game.rows[mouse_y_offset][mouse_x_offset].clicked
      @game.rows[mouse_y_offset][mouse_x_offset].click!
    end
  end
  
  def draw_field(window)
    window.draw_quad 0, 0, Gosu::Color::WHITE, 
                      @pixel_width, 0, Gosu::Color::WHITE, 
                      0, @pixel_height, Gosu::Color::WHITE, 
                      @pixel_width, @pixel_height, Gosu::Color::WHITE
  end
  
  def draw_tiles(window)    
    game.rows.each_with_index do |row, row_index|
      row.each_with_index do |sq, col_index| 
        window.translate(col_index * Tile::Size, row_index * Tile::Size) { sq.draw(window) }
      end
    end
  end
  
end