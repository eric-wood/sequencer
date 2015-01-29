require 'pry'
require 'unimidi'
require_relative 'sequencer/clock'
require_relative 'sequencer/reader'

class Sequencer
  def initialize
    @notes = []
    @clock = Clock.new(notes: @notes)
    @recording = true
    @reader = Reader.new

    start_recording

    # main loop!
    loop do
      puts "Recording: #{@recording}"
      gets
      toggle_recording
    end
  end

  def toggle_recording
    @recording ? stop_recording : start_recording
    @recording = !@recording
  end

  def start_recording
    @clock.stop
    @reader.start
  end

  def stop_recording
    @notes = @reader.stop
    @clock.set_notes(@notes)
    @clock.start
  end
end

Sequencer.new

