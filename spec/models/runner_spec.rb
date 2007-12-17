require File.dirname(__FILE__) + '/../spec_helper'

describe Runner do
  before(:each) do
    @runner = Runner.new
  end

  it "should be valid" do
    @runner.should be_valid
  end
end

describe Runner, "name" do
  before(:each) do
    @runner = Runner.new(:first_name => "Jarno",
                         :last_name => "Salmelin")
  end
  it "should return first and last name" do
    @runner.name.should == "Jarno Salmelin"
  end
end

describe Runner do
  before(:each) do
    @runner = Runner.new    
    @run1 = Run.new
    @run1.stub!(:result).with(7600).and_return("26:03")
    @run2 = Run.new
    @run2.stub!(:result).with(7600).and_return("26:50")
    @run3 = Run.new
    @run3.stub!(:result).with(7600).and_return(nil)
    @runner.stub!(:runs).and_return([@run1, @run2, @run3])
  end
  
  describe "record_run" do
    it "should return run with smallest real time" do
      @runner.record_run(7600).should == @run1
    end
  end
  
  describe "record_time" do
    before(:each) do
      @runner.stub!(:record_run).with(15200).and_return(@run1)
      @run1.stub!(:record).with(15200).and_return("52:41")
    end
    
    it "should return record time" do
      @runner.record_time(15200).should == "52:41"
    end
    
    describe "when record_run nil" do
      before(:each) do
        @runner.stub!(:record_run).with(15200).and_return(nil)
        @run1.should_not_receive(:record)
      end
      
      it "should return nil" do
        @runner.record_time(15200).should be_nil
      end
    end
  end
end