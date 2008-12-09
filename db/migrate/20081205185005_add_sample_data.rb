class AddSampleData < ActiveRecord::Migration
  def self.up
  
    start_date = Date.new(2007, 11, 24)
    runners = []
    events = []

    names = [ 'Hannu Saarijärvi', 'Juho Saarikko', 'Riina Kuuselo', 'Juuso Jutila',
      'Olli Siren', 'Markus Stolze', 'Heikki Virekunnas', 'Elina Virekunnas', 'Elias Kuukka',
      'Antti Kaunisto', 'Päivi Virekunnas', 'Mikko Kaunisto', 'Salla Vahvelainen', 
      'Laura Laakkonen' ]
    
    1.upto(10) do |i|
      date = start_date.advance( :months => i )
      
      event = Event.create( :event_date => date,
        :temperature => rand(20) - rand(30),
        :weather => 'Cold.',
        :story => 'Finland is cold, so we were freezing.' )
      
      fn, ln = names[i].split
      
      runner = Runner.create( :first_name => fn, 
        :last_name => ln,
        :birth_year => 1970 + rand(20),
        :sex => 'H' )
        
      events << event
      runners << runner
    end
    
    events.each do |event|
      runners.each do |runner|
        t3 = (20 + rand(10) ) * 60
        t7 = rand(4) > 0 ? t3 * 2 : nil
        t11 = rand(3) > 0 && t7 ? t3 * 3 : nil
        t15 = rand(2) > 0 && t11 ? t3 * 4 : nil
        Run.create( :runner_id => runner.id,
          :event_id => event.id,
          :time3600 => t3,
          :time7600 => t7,
          :time11200 => t11,
          :time15200 => t15 )
      end
    end
  end

  def self.down
  end
end
