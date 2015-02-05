# Sequencer

A simple little MIDI sequencer to keep Eric from buying more music equipment he doesn't need.

I guess technically this is an arpeggiator, but whatever, I don't want to rename the project.

(why spend money on it if you can build it yourself?)

### Objective

- Hit record
- Play a few notes (timing doesn't matter, just key presses!)
- Hit stop
- Hit play!
- Listen to your notes get played back
- Adjust the speed
- ?????
- Repeat

Here's an [example](http://youtu.be/Rl28UCNWSig?t=39s) of the concept I'm going for (and something I'm sure a lot of you have heard before)

### Running it

If you don't have bundler installed: ```gem install bundler```

Then run ```bundle install``` to make sure you've got all the dependencies installed (don't worry, there's like only one)

Boom:

```bash
ruby lib/sequencer.rb
```

That's it!

### How do I actually *use* it?

Easy.

In recording mode (when it says "RECORDING") you hit a few notes.

* Space: toggle between playback and recording modes
* Arrow keys: adjust tempo
* q: quit, gracefully?

### More info

Stay tuned! Eventually I'm going to try doing a writeup on this once it's in a workable state!

