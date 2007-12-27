require File.dirname(__FILE__) + '/../spec_helper'

describe EventsController, "show" do
  before(:each) do
    @event = mock_model(Event, :event_date => Date.today)
    Event.stub!(:find_by_event_date).and_return(@event)
    @results = []
    @event.stub!(:all_results).and_return(@results)
    
    @tt = mock("TwentyThree")
    TwentyThree.stub!(:new).and_return(@tt)
    @tt.stub!(:photos).and_return([])
  end
  
  def do_get
    get :show, :id => "2007-11-24"
  end
  
  describe "when successful," do
    it "should find event by date" do
      Event.should_receive(:find_by_event_date).
          with("2007-11-24").and_return(@event)
      do_get
    end

    it "should assign event" do
      do_get
      assigns[:event].should == @event
    end

    it "should fetch all results for event" do
      @event.should_receive(:all_results).and_return(@results)
      do_get
    end

    it "should assign results" do
      do_get
      assigns[:results].should == @results
    end
  end
  
  describe "when event not found" do
    before(:each) do
      Event.stub!(:find_by_event_date).and_return(nil)
    end
    
    it "should return 404" do
      do_get
      response.response_code.should == 404
    end
  end
end