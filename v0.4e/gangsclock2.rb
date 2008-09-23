# RubyLearning.org Gangs Clock 2 v0.4e
require 'yaml'
require Dir.pwd + '/render'

::Gang = Struct.new :name, :utc_offset, :country, :n, :avatar

class GangsClock < Shoes 
  url '/', :index
  url '/analog', :analog_clock
  url '/digital', :digital_clock

  include Render
  
  def index
    $color1, $color2, $color3, $color4, $color5, $color6 = darkblue, gold, maroon, green, yellow, bisque
    $gangs = YAML.load_file(Dir.pwd + '/gangsclock.yml')
    analog_clock
  end
  
  def analog_clock    
    show_analog_clock

    $gangs.each do |g|
      fill Dir.pwd + '/' + g.name.split(' ').first.downcase + '.jpg'
      nostroke
      #g.avatar = rect(0, 0, 20, 20, 5).hide
      g.avatar = image(:width => 20, :height => 20){rect(0, 0, 20, 20, 5)}.hide
    end

    show_gangs
    @msg = para('', :left => 60, :top => 300, :stroke => $color3)
    
    every(60){show_gangs}
  end
  
  def digital_clock
    background gradient($color4, $color5)
    para link(strong('A'), :click => '/analog')
    
    image(Dir.pwd + '/gcicon.png', :left => 230).click do
      $color4 = (tmp = ask_color('select background color1')) ? tmp : $color4
      $color5 = (tmp = ask_color('select background color2')) ? tmp : $color5
      $color6 = (tmp = ask_color('select message color')) ? tmp : $color6
      visit '/analog'
      visit '/digital'
    end
    
    @t, @bg = [], []
    $gangs.each_with_index do |g, i|
      fill Dir.pwd + '/' + g.name.split(' ').first.downcase + '.jpg'
      nostroke
      #g.avatar = rect(0, i.next * 25, 20, 20, 5)
      g.avatar = image(:width => 20, :height => 20, :left => 0, :top => i.next * 25){rect(0, 0, 20, 20, 5)}
      fill $color6
      #@bg[i] = rect(30, i.next * 25, 230, 25, 5).hide
      @bg[i] = image(:width => 230, :height => 25, :left => 30, :top => i.next * 25, :radius => 5) do
        rect(0, 0, 230, 25, 5)
      end.hide
      @t[i] = para('', :left => 30, :top => i.next * 25)
      g.avatar.hover{@bg[i].show}
      g.avatar.leave{@bg[i].hide}
    end
    
    show_digital_clock
    
    every(60){show_digital_clock}
  end
end

Shoes.app :title => 'Gangs Clock 2 v0.4e', :width => 270, :height => 625, :resizable => false