class Sequencer
  class Reader
    attr_reader :notes

    def initialize(input=nil)
      @input ||= UniMIDI::Input.use(:first)
      @notes = []
    end

    def start
      @notes = []
      @thread = create_thread
    end

    def stop
      @notes = @thread[:notes]
      Thread.kill(@thread)
      return @notes
    end

    private

    def is_key_on?(note)
      note[:data][0] == 0x90
    end

    def create_thread
      Thread.new do 
        Thread.current[:notes] = []

        loop do
          note = @input.gets.first

          if is_key_on?(note)
            Thread.current[:notes] << note
          end
        end
      end
    end
  end
end
