require File.dirname(__FILE__) + '/../spec_helper'

describe Run do
  before(:each) do
    @run = Run.new
  end

  it "should be valid" do
    @run.should be_valid
  end
end

describe Run, "custom finders" do
  
  describe "find_short" do
    it "should find runs where all other splits are nil except 3600" do
      Run.should_receive(:find).with(:all, :conditions => 
                                            {:time7600 => nil,
                                             :time11200 => nil,
                                             :time15200 => nil},
                                     :order => "time3600")
      Run.find_short                                       
    end
  end

  describe "find_one_lap" do
    it "should find runs where 15200 spli is nil" do
      Run.should_receive(:find).with(:all, :conditions => 
                          "time7600 is not null and time15200 is null",
                                            :order => "time7600")
      Run.find_one_lap              
    end
  end
  
  describe "find_long" do
    it "should find runs where 15200 split is not nil" do
      Run.should_receive(:find).with(:all, 
            :conditions => "time15200 is not null",
            :order => "time15200")
      Run.find_long
    end
  end
  
  describe "find_results_for(7600)" do
    it "should call find_one_lap" do
      Run.should_receive(:find_one_lap)
      Run.find_results_for(7600)
    end
  end
  
  describe "find_results_for(15200)" do
    it "should call find_long" do
      Run.should_receive(:find_long)
      Run.find_results_for(15200)
    end
  end
  
  describe "find_results_for(3600)" do
    it "should call find_short" do
      Run.should_receive(:find_short)
      Run.find_results_for(3600)
    end
  end
end

describe Run do
  before(:each) do
    @run = Run.new
    @run.stub!(:time7600).and_return(1563)
    @run.stub!(:time15200).and_return(3778)
    @run.stub!(:time11200).and_return(nil)
  end
  
  describe "result" do
    it "should return correct string" do
      @run.result(7600).should == "26:03"
    end

    it "should return correct string when over an hour" do
      @run.result(15200).should == "62:58"
    end

    it "should return nil when no such split time" do
      @run.result(11200).should == nil
    end

    it "should return nil when no such method" do
      @run.result(999).should == nil
    end
  end
  
  describe "record" do
    before(:each) do
      @run.stub!(:time3600).and_return(1200)
    end
    
    describe "when no middle split time for the second round" do      
      it "should return the result of the split point" do
        @run.record(7600).should == @run.result(7600)
      end

      it "should return the first lap split for 3600" do
        @run.record(3600).should == @run.result(3600)
      end
    end   
    
    describe "when second lap was faster than the first" do
      before(:each) do
        @run.stub!(:time11200).and_return(2708)
        @run.stub!(:time15200).and_return(3000)
      end
      
      it "should return the time for the second lap" do
        @run.record(7600).should == "23:57"
      end
      
      it "should return the start split of the second lap" do
        @run.record(3600).should == "19:05"
      end
    end
    
    describe "when no splits for the first round with 7600" do
      before(:each) do
        @run.stub!(:time7600).and_return(nil)
      end
      
      it "should return nil" do
        @run.record(7600).should be_nil
      end
    end
    
    describe "when no splits for the first 3600 with 3600" do
      before(:each) do
        @run.stub!(:time3600).and_return(nil)
        @run.stub!(:time11200).and_return(2708)
      end
      
      it "should return second lap split" do
        @run.record(3600).should == "19:05"
      end
    end
    
    describe "when no splits for the first round or 7600 with 3600" do
      before(:each) do
        @run.stub!(:time3600).and_return(nil)
        @run.stub!(:time7600).and_return(nil)
      end
      
      it "should return nil" do
        @run.record(3600).should be_nil
      end
    end
    
    describe "when no second lap" do
      before(:each) do
        @run.stub!(:time15200).and_return(nil)
      end
      
      it "should return first lap result" do
        @run.record(7600).should == @run.result(7600)
      end
    end
    
    describe "when no such method" do
      it "should return nil" do
        @run.record(9000).should be_nil
      end
    end
  end
end