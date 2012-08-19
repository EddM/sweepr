class Mine < Square

  def draw(window)
    if @game.cheat_mode
      @color = Gosu::Color::RED
      super(window)
    else
      if @clicked
        self.class.image.draw(0, 0, Z::Mines)
      else
        super(window)
      end
    end
  end
  
  def click!
    super
    @game.game_over!
    GameWindow.current.audio_bank.play!(:explosion)
  end
  
  def self.image
    @@image ||= Gosu::Image.new(GameWindow.current, "res/bomb.png", false, 0, 0, 16, 16)
  end
  
end