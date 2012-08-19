class Game
  
  Density = 5
  
  attr_reader :width, :height, :rows, :score, :active, :mines
  attr_accessor :cheat_mode
  
  def initialize(width, height)
    @width, @height = width, height
    @squares = width * height
    @mines =  @squares / Density
    @score, @active, @cheat_mode = 0, true, false
    generate!
  end
  
  def score!
    @score += 1
  end
  
  def complete?
    @score >= (@squares - @mines)
  end
  
  def game_over!
    @active = false
  end
  
  def complete!
    @active = false
  end
  
  def generate!
    generate_empty_rows
    populate_mines
  end
  
  def square_at(row, col)
    if in_bounds?(row, col)
      @rows[row][col]
    else
      nil
    end
  end
  
  def in_bounds?(row, col)
    row < @height && row >= 0 && col >= 0 && col < @width
  end
  
  private
  
  def generate_empty_rows
    @rows = []
    height.times do |row|
      this_row = []
      width.times do |col|
        this_row << Space.new(row, col, self)
      end
      @rows << this_row
    end
  end
  
  def populate_mines
    @mines.times do
      row, col = random_coords
      while @rows[row][col] === Mine
        row, col = random_coords
      end
      
      @rows[row][col] = Mine.new(row, col, self)
    end
  end
  
  def random_coords
    [rand(@height), rand(@width)]
  end
  
end