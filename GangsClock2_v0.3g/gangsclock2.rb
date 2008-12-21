# RubyLearning.org Gangs Clock 2 v0.3g
require 'yaml'
require Dir.pwd + '/render'

::Gang = Struct.new :name, :utc_offset, :country, :n, :avatar

Shoes.app :title => 'Gangs Clock 2 v0.3g', :width => 320, :height => 320, :resizable => false do
  extend Render
  @gangs = YAML.load_file(Dir.pwd + '/gangsclock.yml')
  @color1, @color2, @color3 = darkblue, gold, maroon
  @big_pic = ''
  
  def gangs_clock
    show_clock
    #nofill
    #oval :radius => 150, :left => 7, :top => 7, :stroke => white
  
    @gangs.each do |g|
      fill Dir.pwd + '/' + g.name.split(' ').first.downcase + '.jpg'
      nostroke
      #g.avatar = rect(0, 0, 20, 20, 5).hide
      g.avatar = image(:width => 20, :height => 20){rect(0, 0, 20, 20, 5)}.hide
    end
  
    show_gangs
    @msg = para('', :left => 90, :top => 120, :stroke => @color3)
    
    every(60) do
      show_gangs
    end
  end
  
  gangs_clock
  
end
