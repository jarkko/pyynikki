require File.dirname(__FILE__) + '/../../spec_helper'

describe "/events/show" do
  before do
    assigns[:event] = mock_model(Event, :event_date => Date.new(2007,11,24),
                                        :temperature => -2,
                                        :weather => "Hieman liukkaita paikkoja")
    
    assigns[:results] = {7600 => []}
    
    20.times do |i|
      runner = mock_model(Runner,
                          :first_name => "Jamie",
                          :last_name => "Runner #{i}",
                          :name => "Jamie Runner #{i}")
      run = mock_model(Run,
                       :runner => runner,
                       :time3600 => 850 + i * 15,
                       :time7600 => 1706 + i * 30,
                       :time11200 => 2203 + i * 60,
                       :time15200 => 3428 + + i * 90)
      run.stub!(:result).with(7600).and_return("28:#{26 + i}")
      assigns[:results][7600] << run
    end

    render 'events/show'
  end
  
  it "should show heading with the correct date" do
    response.should have_tag("h1", "24.11.2007")
  end
  
  it "should show sidebar with event info" do
    response.should have_tag("#info") do
      with_tag "dd", "-2°C"
      with_tag "dd", "Hieman liukkaita paikkoja"
    end
  end
  
  it "should show results for 7,6km" do
    response.should have_tag("#results")
    response.should have_tag("h2", "7600 m")
    response.should have_tag("tr") do
      with_tag "td", "1"
      with_tag "td", "Jamie Runner 0"
      with_tag "td", "28:26"
    end
  end
end
