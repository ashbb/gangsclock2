# RubyLearning.org Gangs Clock 2 v0.3d
require 'yaml'
require Dir.pwd + '/render'

::Gang = Struct.new :name, :utc_offset, :country, :n, :avatar

Shoes.app :title => 'Gangs Clock 2 v0.3d', :width => 270, :height => 270, :resizable => false do
  extend Render
  @gangs = YAML.load_file(Dir.pwd + '/gangsclock.yml')
  @color1, @color2, @color3 = darkblue, gold, maroon
  
  def gangs_clock
    show_clock
  
    @gangs.each do |g|
      fill Dir.pwd + '/' + g.name.split(' ').first.downcase + '.jpg'
      nostroke
      #g.avatar = rect(0, 0, 20, 20, 5).hide
      g.avatar = image(:width => 20, :height => 20){rect(0, 0, 20, 20, 5)}.hide
    end
  
    show_gangs
    @msg = para('', :left => 60, :top => 80, :stroke => @color3)
    
    every(60) do
      show_gangs
    end
  end
  
  gangs_clock
  
end
