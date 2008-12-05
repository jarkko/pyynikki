class AddSampleData < ActiveRecord::Migration
  def self.up
    event1 = Event.create( :event_date => Date.new(2007, 11, 24),
      :temperature => -3,
      :weather => 'Finland is cold.',
      :story => 'Finland is cold, so we were freezing.' )
      
    runner1 = Runner.create( :first_name => 'Joe', 
      :last_name => 'Pikkola',
      :birth_year => 1970,
      :sex => 'H' )
      
    run1 = Run.create( :runner_id => runner1.id,
      :event_id => event1.id,
      :time3600 => 1*60 + 2*60,
      :time7600 => 2*60 + 2*60,
      :time11200 => 3*60 + 2*60 )
  end

  def self.down
  end
end
