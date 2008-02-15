require File.dirname(__FILE__) + '/../../spec_helper'

describe "/events/new" do
  before do
    assigns[:event] = mock_model(Event,
                          :temperature => "",
                          :new_record? => true,
                          :weather => "")
    render 'events/new'
  end
  
  it "should have a form to create event" do
    response.should have_tag("form[action=#{events_path}]")
  end
  
  it "should have an input for temperature" do
    response.should have_tag("input[name='event[temperature]']")
  end
  
  it "should have an input for weather" do
    response.should have_tag("input[name='event[weather]']")
  end
end
