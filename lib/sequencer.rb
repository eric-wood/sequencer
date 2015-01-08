require 'rubygems'
require 'unimidi'
require 'shoes'
require 'sequencer/clock'
require 'sequencer/gui'

class Sequencer
  include Gui
  include Clock

  # flip to enable debugging without a MIDI device!
  DEBUG = true

  def initialize

    unless DEBUG
      # TODO: make these configurable
      @@input = UniMIDI::Input.use(:first)
      @@output = UniMIDI::Output.use(:first)
    end
  end
end

