require 'rubygems'
require 'gosu'

require './lib/difficulty.rb'
require './lib/tile.rb'
require './lib/z.rb'

require './lib/engine/audio_bank.rb'
require './lib/engine/game_window.rb'
require './lib/engine/game_board.rb'
require './lib/engine/game.rb'
require './lib/entities/square.rb'
require './lib/entities/mine.rb'
require './lib/entities/space.rb'

GameWindow.new(640, 480).show