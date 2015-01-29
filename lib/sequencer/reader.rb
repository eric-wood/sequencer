class Sequencer
  class Reader
    attr_reader :notes

    def initialize(input)
      @input = input
    end

    def start
      @notes = []
      create_thread
    end

    def stop
      Thread.kill(@thread)
      return @notes
    end

    private

    def is_key_on?(note)
      note[:data][0] == 0x90
    end

    def create_thread
      @thread = Thread.new do 
        loop do
          note = @input.gets
          notes << note if is_key_on?(note)
        end
      end
    end
  end
end
