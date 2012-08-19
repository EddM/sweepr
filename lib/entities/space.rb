class Space < Square
  
  def mines_surrounding
    @mines_surrounding ||= squares_surrounding.select { |sq| sq && sq.is_a?(Mine) }.compact
  end
  
  def spaces_surrounding
    @spaces_surrounding ||= squares_surrounding.select { |sq| sq && sq.is_a?(Space) }.compact
  end
  
  def squares_surrounding
    @squares_surrounding ||= [
      @game.square_at(@row - 1, @col),        # top
      @game.square_at(@row - 1, @col + 1),    # top right
      @game.square_at(@row, @col + 1),        # right
      @game.square_at(@row + 1, @col + 1),    # bottom right
      @game.square_at(@row + 1, @col),        # bottom
      @game.square_at(@row + 1, @col - 1),    # bottom left
      @game.square_at(@row, @col - 1),        # left
      @game.square_at(@row - 1, @col - 1)     # top left
    ]
  end
  
  def click!
    super
    @game.score!
    if @game.complete?
      @game.complete!
      GameWindow.current.audio_bank.play!(:win)
    else
      clear_adjacent_spaces! if mines_surrounding.size == 0
      GameWindow.current.audio_bank.play!(:bleep)
    end
  end
  
  def clear_adjacent_spaces!
    spaces_surrounding.each do |sq|
      sq.click! unless sq.clicked
    end
  end
  
  def draw(window)
    if @clicked
      string = "#{mines_surrounding.size > 0 ? mines_surrounding.size : " "}"
      text_width = window.font.text_width(string)
      window.font.draw string, ((InnerSize / 2) - (text_width / 2)) + 2, 0, Z::SquareLabel, 1, 1, Gosu::Color::BLACK
    else
      super(window)
    end
  end
    
end