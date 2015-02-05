class Sequencer
  class Clock
    def initialize(notes: [], paused: true, bpm: 120)
      @output = UniMIDI::Output.use(:first)
      @notes = notes
      @paused = paused
      @bpm = bpm
    end

    def start
      @thread = create_thread
    end

    def stop
      return false unless @thread

      # just to make sure we don't leave any notes hanging...
      @thread[:notes].each do |note|
        note = note[:data]
        note_off(note)
      end

      @notes = []
      Thread.kill(@thread)
    end

    def set_notes(notes)
      @notes = notes
      @thread[:notes] = notes
    end

    def set_bpm(bpm)
      @bpm = bpm
      @thread[:bpm] = @bpm if @thread
    end

    def note_on(note)
      @output.puts(0x90, note[1], note[2])
    end

    def note_off(note)
      @output.puts(0x80, note[1], note[2])
    end

    private

    def create_thread
      Thread.new do
        Thread.current[:bpm] = @bpm
        Thread.current[:notes] = @notes

        loop do
          Thread.current[:notes].each do |note|
            note = note[:data]
            note_on(note)
            sleep(60.0/Thread.current[:bpm])
            note_off(note)
          end
        end
      end
    end
  end
end
