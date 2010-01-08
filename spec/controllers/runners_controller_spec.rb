require File.dirname(__FILE__) + '/../spec_helper'

describe RunnersController do
  describe "GET 'index'" do
    before(:each) do
      @angsti = mock_runner
      @hannu = mock_runner(:name => "Hannu Saarijärvi",
                           :first_name => "Hannu",
                           :last_name => "Saarijärvi")
      @runners = [@angsti, @hannu]
      Runner.stub!(:find).with(:all, :order => "last_name, first_name").and_return(@runners)
      @runners_grouped = {"I" => [@angsti], "S" => [@hannu]}
    end
    
    def do_get
      get :index
    end
    
    it "should fetch runners ordered by name" do
      Runner.should_receive(:find).
        with(:all, :order => "last_name, first_name").
        and_return(@runners)
      do_get
    end
    
    it "should assign runners" do
      do_get
      assigns[:runners].should == @runners_grouped
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @angsti = mock_model(Runner, :name => "Pekka Itävuo")
      Runner.stub!(:find).and_return(@angsti)
      
      @runs = [mock_run, mock_run]
      @angsti.stub!(:runs).and_return(@runs)
      @runs.stub!(:find_recent).and_return(@runs)
    end
    
    def do_get
      get 'show'
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
    
    it "should assign runner" do
      do_get
      assigns[:runner].should == @angsti
    end
    
    it "should set breadcrumbs correctly" do
      do_get
      assigns[:breadcrumbs].should == [{:url => "/", :title => "Pyynikin testijuoksu"},
                                       {:url => "/runners", :title => "Runners"},
                                       {:url => runner_path(@angsti), :title => @angsti.name}]
    end
    
    it "should assign recent results" do
      do_get
      assigns[:recent].should == @runs
    end
  end
end
