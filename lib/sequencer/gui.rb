class Sequencer
  module Gui
    Shoes.app(width: 300, height: 400) do
      stack margin: 20 do
        @record_button = button('Record') do
          @record_button.hide
          @stop_button.show
        end

        @stop_button = button('Stop') do
          @stop_button.hide
          @record_button.show
        end

        @progress = progress(width: 1.0)
      end
    end

    # bleh!!!!
    #Shoes.app height: 200 do
    #  stack margin_left: 10 do
    #    title 'Progress Example'
    #    @p = para
    #  end
    #
    #  pg = progress width: width - 20, height: 20
    #  pg.move 10, 100
    #  animate do |i|
    #    j = i % 100 + 1
    #    pg.fraction = j / 100.0
    #    @p.text = "%2d%" % (pg.fraction * 100)
    #  end
    #end
  end
end
