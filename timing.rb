# IGNORE THIS FOR NOW

require 'unimidi'

@input = UniMIDI::Input.use(:first)
@output = UniMIDI::Output.use(:first)

# TODO: MAKE THIS WORK UGH
def stahp
  @output.puts(13, 123, 0) # all notes off
end

# stop playing notes when we kill the sequencer
trap('INT') do
  stahp
  exit
end

puts "-" * 100
puts "Start playing some notes plz"
puts "-" * 100

data = []
NUM_NOTES = 5

loop do
  break if data.size >= NUM_NOTES
  note = @input.gets.first

  # only add "note on" data
  data << note if note[:data][0] == 0x90
end

puts "cool, thanks for the notes"

# strip out the other details
notes = data.map { |i| i[:data] }

sequencer = Thread.new do
  Thread.current[:delay] = 0.1
  Thread.current[:notes] ||= []

  loop do
    Thread.current[:notes].each do |note|
      @output.puts(0x90, note[1], note[2])
      sleep(Thread.current[:delay])
      @output.puts(0x80, note[1], note[2])
    end
  end
end

sequencer[:notes] = notes

gets
stahp
