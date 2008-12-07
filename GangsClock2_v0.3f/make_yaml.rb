require 'yaml'

data =<<-EOS
utc, 0, UTC/GMT, 4
Anita Kuno, -5, Canada, 0
Brad Coish, -4, Canada, 0
Carlan Calazans, -2, Brazil, 3
Chris Porter, 0, UK, 1
Christopher Bailey, -6, USA, 2
Courtney House, -8, USA, 0
Daniel Kotowski, +1, Poland, 2
Doug Sparling, -6, USA, 4
Felipe Ureta, -6, Ecuador, 3
George Thompson, -6, USA, 0
Jeff Hales, -6, USA, 5
Jerry Anning, -5, USA, 1
Jim Pryke, -6, Canada, 1
Jose Carlos Monteiro, 0, Portugal, 0
Krzysztof Wicher, 0, UK, 2
Leticia Figueira, -2, Brazil, 2
Lowell V, -8, USA, 2
Marcos Ricardo, -2, Brazil, 0
Mareike Hybsier, +1, Germany, 1
Massimiliano Giroldi, -2, Brazil, 4
Michael Uplawski, +1, Germany, 0
Michele Garoche, +1, France, 4
Peter Crawford, +1, Italy, 3
Raul Parolari, -8, USA, 1
Roy Stannard, +7, Thailand, 0
Ryan Fraley, -5, USA, 2
Satish Talim, +5.5, India, 0
Satoshi Asakawa, +9, Japan, 0
Sergio Silva, 0, Portugal, 3
Takaaki Kato, +9, Japan, 1
Victor Goff, -7, USA, 0
Willian Molinari, -2, Brazil, 1
EOS

Gang = Struct.new :name, :utc_offset, :country, :n, :avatar

gangs = []
data.each{|d| gangs << Gang.new( *(d.chomp.split(',') << nil) )}


open('gangsclock.yml', 'w'){|f| f.puts YAML.dump(gangs)}
