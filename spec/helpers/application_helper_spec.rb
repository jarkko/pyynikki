require File.dirname(__FILE__) + '/../spec_helper'

describe ApplicationHelper do
  helper_name :application
  
  describe "breadcrumbs" do
    describe "when breadcrumbs empty" do
      it "should show nothing" do
        breadcrumbs.should == ""
      end
    end
    
    describe "when breadcrumbs exist" do
      before(:each) do
        @breadcrumbs = [{:url => "/", :title => "Pyynikin testijuoksu"},
                                 {:url => "/runners", :title => "Juoksijat"},
                                 {:url => "/runners/69", :title => "Pekka Itävuo"}]
      end
      
      it "should show breadcrumbs separated by &raquo;" do
        breadcrumbs.should ==
%{<a href="/">Pyynikin testijuoksu</a> &raquo;
<a href="/runners">Juoksijat</a> &raquo;
<a href="/runners/69">Pekka Itävuo</a>}
      end
    end
  end
  
  describe "language_links" do
    describe "when locale is finnish" do
      before(:each) do
        I18n.stub!(:locale).and_return(:fi)
      end
      
      it "should show 'In English' active, 'Suomeksi' inactive" do
        language_links == %{<a href="/set_locale/en">In English</a> | Suomeksi}
      end
    end
        
    describe "when locale is english" do
      before(:each) do
        I18n.stub!(:locale).and_return(:en)
      end
      
      it "should show 'In English' inactive, 'Suomeksi' active" do
        language_links == %{In English | <a href="/set_locale/fi">Suomeksi</a>}
      end
    end
  end
end
