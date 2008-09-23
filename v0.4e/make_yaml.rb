require 'yaml'

data =<<-EOS
Anita Kuno, -4, Canada, 0
Brad Coish, -3, Canada, 4
Carlan Calazans, -3, Brazil, 3
Chris Porter, +1, UK, 1
Courtney House, -7, USA, 0
Daniel Kotowski, +2, Poland, 2
George Thompson, -5, USA, 3
Jeff Hales, -5, USA, 1
jerry anning, -4, USA, 1
Jim Pryke, -5, Canada, 2
Jose Carlos Monteiro, +1, Portugal, 0
Krzysztof Wicher, +1, UK, 2
Leticia Figueira, -3, Brazil, 2
Marcos Ricardo, -3, Brazil, 0
Mareike Hybsier, +2, Germany, 1
Michael Uplawski, +2, Germany, 0
Peter Crawford, +2, Italy, 3
Raul Parolari, -7, USA, 1
Roy Stannard, +7, Thailand, 0
Satish Talim, +5.5, India, 0
Satoshi Asakawa, +9, Japan, 0
Victor Goff, -5, USA, 0
Willian Molinari, -3, Brazil, 1
utc, 0, UTC/GMT, 0
EOS

Gang = Struct.new :name, :utc_offset, :country, :n, :avatar

class Gang
  def <=> g
    self.utc_offset.to_f <=> g.utc_offset.to_f
  end
end

gangs = []
data.each{|d| gangs << Gang.new( *(d.chomp.split(',') << nil) )}
gangs.sort!

open('gangsclock.yml', 'w'){|f| f.puts YAML.dump(gangs)}
