class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    
    if @user_session.save
      redirect_to "/admin"
    else
      flash.now[:warning] = "Login failed"
      render :action => "new"
    end
  end
end
