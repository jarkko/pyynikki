require File.dirname(__FILE__) + '/../../spec_helper'

describe "/layouts/application" do
  before(:each) do
    assigns[:breadcrumbs] = [{:url => "/", :title => "Pyynikin testijuoksu"}]
    render 'layouts/application'
  end
  
  it "should show breadcrumbs" do
    response.body.should have_tag("#breadcrumbs") do
      with_tag("a[href='/']", "Pyynikin testijuoksu")
    end
  end
  
  it "should show languages" do
    response.body.should have_tag("#languages") do
      with_tag("a[href='/set_locale/fi']", "Suomeksi")
    end
    response.body.should have_text(/In English/)
  end
end
