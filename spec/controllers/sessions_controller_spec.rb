require 'spec_helper'

describe SessionsController do

  describe "GET new" do
    before(:each) do
      @session = mock("session")
    end
    
    it "should return success" do
      get :new
      response.should be_success
    end
    
    it "should set new UserSession" do
      UserSession.expects(:new).returns(@session)
      get :new
      assigns[:user_session].should == @session
    end
  end

end
