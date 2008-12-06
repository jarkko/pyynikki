
Given /^I\'m a "(.*)" user$/ do |nationality|
  # are @instance_variables prohibited?
  @langcode = ( nationality == 'finn' ) ? 'fi' : 'en'
end

Given /^I have an event, a runner and his run$/ do
  event = Event.create!( :event_date => Date.new(2007, 11, 24),
    :temperature => -3,
    :weather => 'Finland is cold.',
    :story => 'Finland is cold, so we were freezing.' )
  runner = Runner.create!( :first_name => 'Joe', 
    :last_name => 'Pikkola',
    :birth_year => 1970,
    :sex => 'H' )
  run = Run.create!( :runner_id => runner.id,
    :event_id => event.id,
    :time3600 => 1*60 + 2*60,
    :time7600 => 2*60 + 2*60,
    :time11200 => 3*60 + 2*60 )
end

When /^I visit the "(.*)" page$/ do |page|
  # webrat#visits( url, method, data )
  params = [ :get, { :locale => @langcode } ]
  case page
  when 'home'
    params.unshift( '/' )
  when 'event'
    params.unshift( '/events/2007-11-24' )
  when 'runner\'s profile'
    params.unshift( '/runners/1-joe-pikkola' )
  end
  visits( *params )
end
