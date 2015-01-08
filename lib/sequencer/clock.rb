class Sequencer
  module Clock
    @@timing_thread = Thread.new do
      Thread.current[:delay] = 0.1
      Thread.current[:notes] ||= []

      loop do
        Thread.current[:notes].each do |note|
          unless DEBUG
            @@output.puts(0x90, note[1], note[2])
          else
            puts "Out: #{note[1]}"
          end

          sleep(Thread.current[:delay])

          unless DEBUG
            @@output.puts(0x80, note[1], note[2])
          end
        end
      end
    end
  end
end
