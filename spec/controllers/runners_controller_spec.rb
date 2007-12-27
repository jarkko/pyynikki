require File.dirname(__FILE__) + '/../spec_helper'

describe RunnersController do
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @angsti = mock_model(Runner, :name => "Pekka Itävuo")
      Runner.stub!(:find).and_return(@angsti)
    end
    
    def do_get
      get 'show'
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
    
    it "should assign runner" do
      do_get
      assigns[:runner].should == @angsti
    end
  end
end
