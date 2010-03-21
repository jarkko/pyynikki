require 'csv'
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

file = ARGV[0] || "/Users/jarkko/Documents/punakone/TP_testijuoksu_paivat.csv"

data = CSV.open(file, "r")
headers = data.shift

data.each do |row|
  date, temperature, weather = row
  date.gsub!(/(\d\d)\.(\d\d)\.(\d\d\d\d)/, '\3-\2-\1')

  Event.create! :event_date => date,
                 :temperature => temperature,
                 :weather => weather
end
