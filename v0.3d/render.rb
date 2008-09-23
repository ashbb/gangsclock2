module Render
  def show_clock
    background gradient @color1, @color2
    pos = [[125, 0], [157, 4], [187, 16], [213, 36], [233, 62], [245, 92],
       [250, 125], [245, 157], [233, 187], [213, 213], [185, 233], [155, 243],
       [123, 245], [92, 243], [62, 233], [36, 213], [16, 187], [3, 157],
       [0, 122], [3, 92], [15, 62], [35, 36], [61, 16], [91, 4]]
       
    pos.each_with_index{|n, i| para strong(i), :left => n[0], :top=> n[1], :stroke => white}
    
    image(Dir.pwd + '/gcicon.png').click do
      @color1 = (tmp = ask_color('select background color1')) ? tmp : @color1 
      @color2 = (tmp = ask_color('select background color2')) ? tmp : @color2
      @color3 = (tmp = ask_color('select message color')) ? tmp : @color3
      clear{gangs_clock}
    end
  end
  
  def position utc_offset, n
    r = 100 - 20 * n
    t = Time.new.getgm + utc_offset.to_f * 3600
    h = t.hour
    m = t.min
    theta = (h * 60.0 + m) * 360 / (24 * 60.0)
    case h
      when 0..6
        radian = theta * Math::PI / 180.0
        x = 125 + r * Math.sin(radian)
        y = 125 - r * Math.cos(radian)
      when 7..12
        radian = (theta - 90.0) * Math::PI / 180.0
        y = 125 + r * Math.sin(radian)
        x = 125 + r * Math.cos(radian)
      when 13..18
        radian = (theta - 180.0) * Math::PI / 180.0
        x = 125 - r * Math.sin(radian)
        y = 125 + r * Math.cos(radian)
      when 19..24
        radian = (theta - 270.0) * Math::PI / 180.0
        y = 125 - r * Math.sin(radian)
        x = 125 - r * Math.cos(radian)
      else
    end
    return x.to_i, y.to_i
  end
  
  def show_gangs
    @gangs.each do |g|
      g.avatar.show.move *(position(g.utc_offset, g.n.to_i))
      g.avatar.hover do
        @msg.replace strong(g.name, "\n", g.country, "\n", (Time.new.getgm + g.utc_offset.to_f * 3600).to_s[0..-13])
      end
      g.avatar.leave do
        @msg.replace ''
      end
    end
  end
  
end