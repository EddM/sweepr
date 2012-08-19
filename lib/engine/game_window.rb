class GameWindow < Gosu::Window
  
  attr_reader :font, :audio_bank
  
  def initialize(width, height)
    super(width, height, false)
    self.caption = "Sweepr"
    @@current = self 
    
    @audio_bank = AudioBank.new(self)
    @board = GameBoard.new(self, Difficulty::Hard)
    @font = Gosu::Font.new(self, "res/8bitoperator_jve.ttf", 16)
    @keylog = []
  end
  
  def update
    self.caption = "Sweepr (#{Gosu.fps} fps)"
    @board.update(self)
    new_game if button_down?(Gosu::KbR)
    exit if button_down?(Gosu::KbEscape)
    check_cheat_code
  end
  
  def button_down(id)
    @keylog << id
  end
  
  def draw
    @board.draw(self)
    draw_score
  end
  
  def needs_cursor?
    true
  end
  
  def self.current
    @@current
  end
  
  private
  
  def check_cheat_code
    if @keylog[-10..-1] == [126, 126, 125, 125, 123, 124, 123, 124, 11, 0]
      @board.game.cheat_mode = true
    end
  end
  
  def new_game
    @board = GameBoard.new(self, Difficulty::Easy)
  end
  
  def draw_score
    score_text = "Score: #{@board.game.score}"
    @font.draw score_text, 10, 10, Z::HUD
    unless @board.game.active
      score_text_width = @font.text_width(score_text)
      @font.draw "GAME OVER. Press R for new game.", 10 + score_text_width + 10, 10, Z::HUD, 1, 1, Gosu::Color::RED
    end
    
    if @board.game.cheat_mode
      @font.draw "ZOMG cheater!!11", 10, 30, Z::HUD, 1, 1, Gosu::Color::YELLOW
    end
  end
  
end