require 'spec_helper'

describe Admin::EventsController do

  #Delete this example and add some real ones
  it "should use Admin::EventsController" do
    controller.should be_an_instance_of(Admin::EventsController)
  end

  describe "GET index" do
    describe "when not logged in" do
      it "should redirect to user_sessions/new" do
        get :index
        response.should redirect_to(new_user_session_path)
      end
    end    
  end
end
