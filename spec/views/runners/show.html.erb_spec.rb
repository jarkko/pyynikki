require File.dirname(__FILE__) + '/../../spec_helper'

describe "/runners/show" do
  before(:each) do
    assigns[:runner] = @runner = mock_model(Runner, :name => "Pekka Itävuo")
    @runner.stub!(:record_time).with(15200).and_return("56:12")
    @runner.stub!(:record_time).with(7600).and_return("26:03")
    @runner.stub!(:record_time).with(3600).and_return("12:50")
    
    @event = mock_model(Event, :event_date => Date.new(2003,11,20))
    @run = mock_model(Run, :event => @event)
    @runner.stub!(:record_run).and_return(@run)
    render 'runners/show'
  end
  
  it "should show the runner name in the heading" do
    response.should have_tag('h1', /Pekka Itävuo/)
  end
  
  it "should show records" do
    response.should have_tag('div#records') do
      with_tag("h2", /Ennätykset/)
      with_tag("tr") do
        with_tag("td", /15,2 km/)
        with_tag("td", /56:12/)
        with_tag("td") do
          with_tag("a[href=#{event_path(@event, :anchor => "run_#{@run.to_param}")}]", /20.11.2003/)
        end
      end
      with_tag("tr") do
        with_tag("td", /7,6 km/)
        with_tag("td", /26:03/)
        with_tag("td") do
          with_tag("a[href=#{event_path(@event, :anchor => "run_#{@run.to_param}")}]", /20.11.2003/)
        end      end
    end
  end
end
