require File.dirname(__FILE__) + '/../spec_helper'

describe Run, "when saved" do
  before(:each) do
    @person = mock_model(Runner, :age_class_with_gender => "H35", :valid? => true)
    @event = mock_model(Event, :event_date => Date.today, :valid? => true)
    @run = Run.new(:event => @event, :event_id => @event.id, :runner_id => @person.id)
    @run.stub!(:runner).and_return(@person)
  end
  
  it "should update age_class correctly" do
    @run.save
    @run.age_class.should == "H35"
  end
end