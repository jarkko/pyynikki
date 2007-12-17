require 'csv'
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

file = ARGV[0] || "/Users/jarkko/Documents/punakone/TP_testijuoksu_nimet.csv"

data = CSV.open(file, "r")
headers = data.shift

data.each do |row|
  name, birth_year, sex = row
  first_name, last_name = name.split(" ")

  Runner.create! :first_name => first_name,
                 :last_name => last_name,
                 :birth_year => birth_year,
                 :sex => sex
end
