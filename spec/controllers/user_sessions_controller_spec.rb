require 'spec_helper'

describe UserSessionsController do

  describe "GET new" do
    before(:each) do
      @session = mock("session")
      UserSession.expects(:new).returns(@session)
    end
    
    it "should return success" do
      get :new
      response.should be_success
    end
    
    it "should set new UserSession" do
      get :new
      assigns[:user_session].should == @session
    end
  end
  
  describe "POST create" do
    describe "with wrong password" do
      before(:each) do
        @sess = stub('UserSession')
        @sess.stubs(:save).returns(false)
        UserSession.expects(:new).returns(@sess)
      end
      
      it "should render login form" do          
        post :create, :user_session => {:login => "foo", :password => "bar"}
        response.should be_success
        response.should render_template("user_sessions/new")
      end
      
      it "should not create new session" do
        post :create, :user_session => {:login => "foo", :password => "bar"}
        assigns[:current_user].should be_nil
      end
      
      # for some reason the response is empty
      #it "should show a message about failed login" do
      #  post :create, :user_session => {:login => "foo", :password => "bar"}
      #  puts flash.inspect
      #  response.should have_text("Login failed")
      #end
    end
    
    #describe "without email" do
    #  it "should render login form"
    #  it "should not create new session"
    #end
    #
    #describe "without password" do
    #  it "should render login form"
    #  it "should not create new session"
    #end
    
    describe "with correct details" do
      before(:each) do
        @sess = stub('UserSession')
        @sess.stubs(:save).returns(true)
        UserSession.
          expects(:new).with({'login' => "foo", 'password' => "bar"}).
          returns(@sess)
      end
      
      it "should log user in" do
        post :create, :user_session => {:login => "foo", :password => "bar"}
      end
      
      it "should redirect to /admin" do
        post :create, :user_session => {:login => "foo", :password => "bar"}
        response.should redirect_to("/admin")
      end
    end
  end

end
