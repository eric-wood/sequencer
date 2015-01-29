class Sequencer
  class Clock
    def initialize(output, notes: [], paused: true, bpm: 120)
      @output = output
      @notes = notes
      @paused = paused
      @bpm = bpm
      create_thread
    end

    def start
      @thread[:paused] = false
    end

    def stop
      @thread[:paused] = true
    end

    def set_notes(notes)
      @thread[:notes] = notes
    end

    private

    def create_thread
      @thread = Thread.new do
        Thread.current[:bpm] = @bpm
        Thread.current[:notes] = @notes
        Thread.current[:paused] = true

        loop do
          continue if Thread.current[:paused]

          Thread.current[:notes].each do |note|
            @output.puts(0x90, note[1], note[2])
            puts "Out: #{note}"

            sleep(Thread.current[:delay])

            @output.puts(0x80, note[1], note[2])
          end
        end
      end
    end
  end
end
