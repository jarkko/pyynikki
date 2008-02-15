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
    @runner = Runner.new(:birth_year => (Time.now.year - 38),
                         :sex => "H",
                         :first_name => "Jarno",
                         :last_name => "Salmelin",
                         :id => 69)  
    @run1 = Run.new
    @run1.stub!(:record).with(7600).and_return("26:03")
    @run2 = Run.new
    @run2.stub!(:record).with(7600).and_return("26:50")
    @run3 = Run.new
    @run3.stub!(:record).with(7600).and_return(nil)
    @runner.stub!(:runs).and_return([@run1, @run2, @run3])
  end
  
  describe "record_run" do
    it "should return run with smallest real time" do
      @runner.record_run(7600).should == @run1
    end
    
    describe "when no times for the length" do
      before(:each) do
        @run1.stub!(:record).with(15200).and_return(nil)
        @run2.stub!(:record).with(15200).and_return(nil)
        @run3.stub!(:record).with(15200).and_return(nil)
      end
      
      it "should return nil" do
        @runner.record_run(15200).should == nil
      end
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
  
  describe "age_class" do
    it "should return 35 if 37" do
      @runner.age_class.should == 35
    end
    
    it "should have returned 21 5 years ago" do
      @runner.age_class(5.years.ago).should == 21
    end
    
    it "should return 18 if 17" do
      @runner.stub!(:age).and_return(17)
      @runner.age_class.should == 18
    end
    
    it "should return 21 if 33" do
      @runner.stub!(:age).and_return(33)
      @runner.age_class.should == 21
    end
  end
  
  describe "age" do
    it "should return the difference between birth_year and current year" do
      @runner.age.should == (Time.now.year - @runner.birth_year)
    end
    
    describe "with at parameter" do
      it "should return the difference between when year and birth_year" do
        @runner.age(3.years.ago).should == (3.years.ago.year - @runner.birth_year)
      end
    end
  end
  
  describe "age_class_with_gender" do
    describe "when male and 35" do
      it "should return H35" do
        @runner.age_class_with_gender.should == "H35"
      end
    end

    describe "when female and 18" do
      before(:each) do
        @runner.stub!(:sex).and_return("D")
        @runner.stub!(:age_class).and_return(18)
      end
      
      it "should return D18" do
        @runner.age_class_with_gender.should == "D18"
      end
    end
    
    describe "with at parameter" do
      before(:each) do
        Time.stub!(:now).and_return(:foo)
        @runner.stub!(:age_class).with(Time.now).and_return(21)
      end
      
      it "should call age_class with the parameter" do
        @runner.should_receive(:age_class).with(Time.now)
        @runner.age_class_with_gender(Time.now)
      end
      
      it "should return H21" do
        @runner.age_class_with_gender(Time.now).should == "H21"
      end
    end
  end
  
  describe "to_param" do
    before(:each) do
      @runner.stub!(:id).and_return(69)
    end
    
    it "should return id and name sanitized" do
      @runner.to_param.should == "69-jarno-salmelin"
    end
  end
  
  describe "title" do
    it "should return name" do
      @runner.title.should == @runner.name
    end
  end
end