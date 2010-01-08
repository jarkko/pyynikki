require File.dirname(__FILE__) + '/../../spec_helper'

describe "/runners/show" do
  before(:each) do
    I18n.default_locale = :fi
    assigns[:runner] = @runner = mock_model(Runner, :name => "Pekka Itävuo")
    @runner.stub!(:record_time).with(15200).and_return("56:12")
    @runner.stub!(:record_time).with(7600).and_return("26:03")
    @runner.stub!(:record_time).with(3600).and_return("12:50")
    
    @event = mock_model(Event, 
                        :event_date => Date.new(2003,11,20),
                        :to_param => "2003-11-20")
    @run = mock_model(Run, 
                      :event => @event,
                      :length => "15,2 km",
                      :result => "56:12",
                      :splits => "(14:00, 28:00, 42:00)")
                      
    @runner.stub!(:record_run).and_return(@run)
    
    assigns[:recent] = {"2007" => [@run], "2006" => [@run]}
    render 'runners/show'
  end
  
  it "should show the runner name in the heading" do
    response.should have_tag('h1', /Pekka Itävuo/)
  end
  
  it "should show records" do
    response.should have_tag('div#records') do
      with_tag("h2", /Records/)
      with_tag("tr") do
        with_tag("td", /15.2 km/)
        with_tag("td", /56:12/)
        with_tag("td") do
          with_tag("a[href=#{event_path(@event, :anchor => "run_#{@run.to_param}")}]", /20.11.2003/)
        end
      end
      with_tag("tr") do
        with_tag("td", /7.6 km/)
        with_tag("td", /26:03/)
        with_tag("td") do
          with_tag("a[href=#{event_path(@event, :anchor => "run_#{@run.to_param}")}]", /20.11.2003/)
        end
      end
    end
  end
  
  it "should show recent results" do
    response.should have_tag("#recent") do
      with_tag("#run_#{@run.id}") do
        with_tag("a[href=#{event_path(@run.event, :anchor => "run_#{@run.id}")}]",
                 "20.11.2003")
                 
        with_tag("td", "15,2 km")
        
        with_tag(".result", "56:12")
        
        with_tag(".splits", "(14:00, 28:00, 42:00)")
      end
    end
  end
end
