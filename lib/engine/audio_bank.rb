class AudioBank
  
  def initialize(window)
    samples = Dir.glob("res/*.wav").map do |file| 
      [file.split(/\.|\//)[-2].to_sym, Gosu::Sample.new(window, file)]
    end
    
    @sounds, @playing_sounds = Hash[*samples.flatten], {}
  end
  
  def play!(name)
    unless @playing_sounds[name] && @playing_sounds[name].playing?
      @playing_sounds[name] = @sounds[name].play
    end
  end
  
end