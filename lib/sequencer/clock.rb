class Sequencer
  class Clock
    def initialize(notes: [], paused: true, bpm: 120)
      @output = UniMIDI::Output.use(:first)
      @notes = notes
      @paused = paused
      @bpm = bpm
      @thread = create_thread
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
      Thread.new do
        begin
          Thread.current[:bpm] = @bpm
          Thread.current[:notes] = @notes
          Thread.current[:paused] = true

          loop do
            continue if Thread.current[:paused]
            puts "woot"

            Thread.current[:notes].each do |note|
              @output.puts(0x90, note[1], note[2])
              puts "Out: #{note}"

              sleep(Thread.current[:delay])

              @output.puts(0x80, note[1], note[2])
            end
          end
        rescue e
          puts "DANGER DANGER"
          puts e
        end
      end
    end
  end
end
