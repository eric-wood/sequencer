require 'rubygems'
require 'unimidi'
require 'shoes'
require 'sequencer/clock'
require 'sequencer/gui'

class Sequencer
  include Gui
  include Clock

  def initialize
  end
end

Sequencer.new

