# encoding: UTF-8

require File.dirname(__FILE__) + '/../spec_helper'

describe ApplicationHelper do  
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
end
