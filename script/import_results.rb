require 'csv'
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

file = ARGV[0] || "/Users/jarkko/Documents/punakone/TP_testijuoksu_tulokset.csv"

data = CSV.open(file, "r")
headers = data.shift

data.each do |row|
  name, date, time3600, time7600, time11200, time15200 = row
  date.gsub!(/(\d{1,2})\.(\d{1,2})\.(\d\d\d\d)/, '\3-\2-\1')
  
  first_name, last_name = name.split(" ")
  times = {}
  [:time3600, :time7600, :time11200, :time15200].each do |time|
    value = eval(time.to_s)
    if value.blank?
      times[time] = nil
      next
    end
    hours, minutes, seconds = value.split(":")
    value = 3600 * hours.to_i + 60 * minutes.to_i + seconds.to_i
    times[time] = value
  end 
  
  runner = Runner.find_by_first_name_and_last_name(first_name, last_name)
  event = Event.find_by_event_date(date)
  
  runner.runs.create! times.merge(:event => event)  
end
