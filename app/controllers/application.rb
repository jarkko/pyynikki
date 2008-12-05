# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'df6609ba6896ed0f525725d20c34712b'

  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password  
  
  before_filter :init_breadcrumbs, :add_controller_specific_breadcrumb
  
  def not_found
    render :text => "Not found", :status => 404
  end
  
  private
  
  def init_breadcrumbs
    @breadcrumbs = [{:url => root_path, :title => "Pyynikin testijuoksu"}]
  end
  
  def add_controller_specific_breadcrumb
    @titles = {"events" => "Testijuoksut", "runners" => "Juoksijat"}
    @breadcrumbs << {:url => send(params[:controller] + "_path"),
                     :title => @titles[params[:controller]]}
  end
end
