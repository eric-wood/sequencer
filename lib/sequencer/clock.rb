class Sequencer
  module Clock
    @@timing_thread = Thread.new do
      Thread.current[:delay] = 0.1
      Thread.current[:notes] ||= []
      Thread.current[:paused] = true

      loop do
        Thread.current[:notes].each do |note|
          #@@output.puts(0x90, note[1], note[2])
          puts "Out: #{note}"

          sleep(Thread.current[:delay])

          #@@output.puts(0x80, note[1], note[2])
        end
      end
    end

    @@timing_thread[:notes] = [[1,2],[3,4]]
  end
end
