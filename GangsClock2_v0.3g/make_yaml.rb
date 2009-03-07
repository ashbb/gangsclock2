require 'yaml'

data =<<-EOS
Ahmed Hazem, +2, Egypt, 2
Al Snow, -5, USA, 4
Anita Kuno, -5, Canada, 0
Brad Coish, -4, Canada, 0
Carlan Calazans, -2, Brazil, 3
Chris Porter, 0, UK, 4
Christopher Bailey, -6, USA, 2
Courtney House, -8, USA, 0
Daniel Kotowski, +1, Poland, 2
Dave Lilley, +13, New Zealand, 0
Doug Sparling, -6, USA, 4
Dylan Clendenin, -8, USA, 4
Felipe Ureta, -6, Ecuador, 3
George Thompson, -6, USA, 0
Hector Sansores, -6, Mexico, 6
Ian Dees, -8, USA, 3
Ilian Mitev, +2, Bulgaria, 0
James Silberbauer, +2, South Africa, 1
Jeff Hales, -6, USA, 5
Jerry Anning, -5, USA, 1
Jim Pryke, -6, Canada, 1
Jose Carlos Monteiro, 0, Portugal, 0
Krzysztof Wicher, 0, UK, 1
Leticia Figueira, -2, Brazil, 2
Lowell Vizon, -8, USA, 2
Marcos Ricardo, -2, Brazil, 0
Mareike Hybsier, +1, Germany, 1
Massimiliano Giroldi, -2, Brazil, 4
Michael Uplawski, +1, Germany, 0
Michael_Kohl, +1, Austria, 5
Michele Garoche, +1, France, 4
Peter Crawford, +1, Italy, 3
Raul Parolari, -8, USA, 1
Roy Stannard, +7, Thailand, 0
Ryan Fraley, -5, USA, 2
Sami Ahmed, 0, UK, 2
Satish Talim, +5.5, India, 0
Satoshi Asakawa, +9, Japan, 0
Sergio Silva, 0, Portugal, 3
suman gurung, -5, USA, 3
Takaaki Kato, +9, Japan, 1
Victor Goff, -7, USA, 0
Willian Molinari, -2, Brazil, 1
EOS

Gang = Struct.new :name, :utc_offset, :country, :n, :avatar

gangs = []
data.each{|d| gangs << Gang.new( *(d.chomp.split(',') << nil) )}


open('gangsclock.yml', 'w'){|f| f.puts YAML.dump(gangs)}
