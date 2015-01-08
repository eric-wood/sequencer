require 'rubygems'
require 'unimidi'
require 'shoes'
require_relative 'sequencer/clock'
require_relative 'sequencer/gui'

class Sequencer
  include Clock
  include Gui

  def initialize
    # TODO: make these configurable
    #@@input = UniMIDI::Input.use(:first)
    #@@output = UniMIDI::Output.use(:first)
  end
end

