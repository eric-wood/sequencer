require 'curses'

class Sequencer
  module Gui
    def init_screen
      Curses.noecho
      Curses.curs_set(0)
      Curses.init_screen
      Curses.start_color
      Curses.stdscr.keypad(true)
      init_colors

      begin
        yield
      ensure
        Curses.close_screen
      end
    end

    def init_colors
      Curses.init_pair(Curses::COLOR_GREEN,
                       Curses::COLOR_GREEN,
                       Curses::COLOR_BLACK) 

      Curses.init_pair(Curses::COLOR_RED,
                       Curses::COLOR_RED,
                       Curses::COLOR_BLACK)
    end

    def write_block(x, y, text)
      text.split.each_with_index do |row,i|
        Curses.setpos(y+i, x)
        Curses.addstr(row)
      end
    end

    def write(x, y, text, color=nil)
      if color
        name = "COLOR_#{color.to_s.upcase}"
        const = Curses.const_get(name)

        Curses.attron(Curses.color_pair(const|Curses::A_NORMAL)) do
          Curses.setpos(x, y)
          Curses.addstr(text)
        end
      else
        Curses.setpos(x, y)
        Curses.addstr(text)
      end
    end

    def start_gui
      init_screen do
        loop do
          Curses.clear()
          write(0, 1, '[sequencer]')

          if @recording
            write(2, 1, 'RECORDING', :red)
          else
            write(2, 1, 'PLAYING', :green)
          end

          write(3, 1, "BPM: #{@bpm}")
          Curses.refresh

          handle_input(Curses.getch)
        end
      end
    end

    def handle_input(input)
      case input
      when Curses::Key::UP
        @bpm += 1
      when Curses::Key::DOWN
        @bpm -= 1
      when ' '
        toggle_recording
      when 'q'
        exit(0)
      end
    end
  end
end
