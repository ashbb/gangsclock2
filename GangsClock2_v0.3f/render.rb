module Render
  def show_clock
    background gradient @color1, @color2
    pos = [[150, 0], [188, 5], [225, 20], [256, 43], [279, 74], [294, 111], 
          [300, 150], [294, 188], [279, 225], [256, 256], [225, 279], [188, 294], 
          [150, 300], [111, 294], [75, 279], [43, 256], [20, 225], [5, 188], 
          [0, 150], [5, 111], [20, 75], [43, 43], [74, 20], [111, 5]]
          
    pos.each_with_index{|n, i| para strong(i), :left => n[0], :top=> n[1], :stroke => white}
    
    image(Dir.pwd + '/gcicon.png').click do
      @color1 = (tmp = ask_color('select background color1')) ? tmp : @color1 
      @color2 = (tmp = ask_color('select background color2')) ? tmp : @color2
      @color3 = (tmp = ask_color('select message color')) ? tmp : @color3
      clear{gangs_clock}
    end
  end
  
  def position utc_offset, n
    cr = 145
    r = (cr - 20) - 20 * n
    t = Time.new.getgm + utc_offset.to_f * 3600
    h = t.hour
    m = t.min
    theta = (h * 60.0 + m) * 360 / (24 * 60.0)
    case h
      when 0..6
        radian = theta * Math::PI / 180.0
        x = cr + r * Math.sin(radian)
        y = cr - r * Math.cos(radian)
      when 7..12
        radian = (theta - 90.0) * Math::PI / 180.0
        y = cr + r * Math.sin(radian)
        x = cr + r * Math.cos(radian)
      when 13..18
        radian = (theta - 180.0) * Math::PI / 180.0
        x = cr - r * Math.sin(radian)
        y = cr + r * Math.cos(radian)
      when 19..24
        radian = (theta - 270.0) * Math::PI / 180.0
        y = cr - r * Math.sin(radian)
        x = cr - r * Math.cos(radian)
      else
    end
    return x.to_i, y.to_i
  end
  
  def show_gangs
    @gangs.each do |g|
      #g.avatar.show.move *(position(g.utc_offset, g.n.to_i))
      x, y = position(g.utc_offset, g.n.to_i)
      g.avatar.show.move x + 7, y + 7
      g.avatar.hover do
        @msg.replace strong(g.name, "\n", g.country, "\n", (Time.new.getgm + g.utc_offset.to_f * 3600).to_s[0..-13])
      end
      g.avatar.leave do
        @msg.replace ''
        @gangs.each{|e| e.avatar.show}
        @big_pic.remove
        @msg.move 90, 120
      end
      g.avatar.click do
        @gangs.each{|e| e.avatar.hide}
        @big_pic = image(Dir.pwd + '/b-' + g.name.split(' ').first.downcase + '.jpg', :left => 110, :top => 60)
        @msg.move 90, 170
      end
    end
  end
  
end