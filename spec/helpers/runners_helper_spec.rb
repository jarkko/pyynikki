require File.dirname(__FILE__) + '/../spec_helper'

describe RunnersHelper do
  helper_name :runners
  
  #Delete this example and add some real ones or delete this file
  it "should include the RunnersHelper" do
    included_modules = self.metaclass.send :included_modules
    included_modules.should include(RunnersHelper)
  end
  
end
