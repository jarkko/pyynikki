# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  #include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'df6609ba6896ed0f525725d20c34712b'

  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password  
  filter_parameter_logging :password, :password_confirmation
  
  before_filter :init_breadcrumbs
  before_filter :add_controller_specific_breadcrumb, :except => [:set_locale]
  
  def not_found
    render :text => t('app.common.not_found'), :status => 404
  end

  def set_locale
    return if not params[:locale]
    I18n.default_locale = I18n.locale = params[:locale]
    # can it cause problems if redirected to a POST page? (double submitting?)
    redirect_to :back
  end
  
  private
  
  def init_breadcrumbs
    @breadcrumbs = [{:url => root_path, :title => t('app.common.pyynikki_test_run')}]
  end
  
  def add_controller_specific_breadcrumb
    @titles = {
      "events" => t('app.common.test_runs'),
      "runners" => t('app.common.runners')
    }
    # send("events_path") == eval("events_path")
    @breadcrumbs << {:url => send(params[:controller].gsub("/", "_") + "_path"),
                     :title => @titles[params[:controller]]}
  end
  
  helper_method :current_user_session, :current_user

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to admin_path
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
