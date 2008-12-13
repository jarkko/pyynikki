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
    @breadcrumbs << {:url => send(params[:controller] + "_path"),
                     :title => @titles[params[:controller]]}
  end
end
