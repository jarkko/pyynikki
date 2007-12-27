require File.dirname(__FILE__) + '/../spec_helper'

describe Event, "all_results" do
  before(:each) do
    @runs = []
    @event = Event.new
    @event.stub!(:runs).and_return(@runs)
    @run = mock_model(Run)
    @runs.stub!(:find_results_for).and_return([@run])
  end
  
  it "should call all find_results_for variants" do
    [3600, 7600, 15200].each do |length|
      @runs.should_receive(:find_results_for).with(length)      
    end
    @event.all_results
  end
  
  it "should return a hash of run results" do
    @event.all_results.should == {7600 => [@run],
                                  3600 => [@run],
                                  15200 => [@run]}
  end
end

describe Event do
  before(:each) do
    @event = Event.new
    @event.event_date = "20071124"
    @event.temperature = 2
  end
  
  describe "to_param" do
    it "should return date" do
      @event.to_param.should == "2007-11-24"
    end
  end
  
  describe "temperature_with_sign" do
    it "should return temperature with plus sign when greater than zero" do
      @event.temperature_with_sign.should == "+2"
    end
    
    it "should return temperature with minus sign when less than zero" do
      @event.temperature = -5
      @event.temperature_with_sign.should == "-5"
    end
  end
end