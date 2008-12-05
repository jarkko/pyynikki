
Given /I have an event at "(.*)" in the database/ do |date|
  event = Event.create!( :event_date => Date.new(2007, 11, 24) )
end

When /I have a runner at that event, called "(.*) (.*)"/ do |fn, ln|
  runner = Runner.create!( :first_name => fn, 
    :last_name => ln,
    :birth_year => 1970,
    :sex => 'H' )
end

When /I have his run with time "(\d\d):(\d\d)"/ do |min, sec|
  run = Run.create!( :runner_id => Runner.find(:first).id,
    :event_id => Event.find(:first).id,
    :time3600 => min*60 + sec*60 )
end

When /^I visit the home page \(=index page\)$/ do
  visits "/"
end
