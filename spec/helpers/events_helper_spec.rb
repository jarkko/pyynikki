require File.dirname(__FILE__) + '/../spec_helper'

describe EventsHelper do
  helper_name :events
  
  before(:each) do
    @event = mock_model(Event,
                        :temperature => 2,
                        :temperature_with_sign => "+2")
  end
  
  describe "temperature when above zero" do
    it "should show signed temperature with plus class" do
      temperature(@event).should == "<dd class=\"plus\">+2°C</dd>"
    end
  end
  
  describe "temperature when below zero" do
    before(:each) do
      @event.stub!(:temperature).and_return(-2)
      @event.stub!(:temperature_with_sign).and_return("-2")
    end
    
    it "should show signed temperature with minus class" do
      temperature(@event).should == "<dd class=\"minus\">-2°C</dd>"
    end
  end
end
