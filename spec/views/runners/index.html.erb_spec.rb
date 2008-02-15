require File.dirname(__FILE__) + '/../../spec_helper'

describe "/runners/index" do
  before(:each) do
    @angsti = mock_runner
    @hannu = mock_runner(:name => "Hannu Saarijärvi")
    assigns[:runners] = @runners = {"I" => [@angsti], "S" => [@hannu]}
    render 'runners/index'
  end
  
  it "should have items for each runner" do
    @runners.values.flatten.each do |runner|
      response.should have_tag("a[href=#{runner_path(runner)}]", runner.name)
    end
  end
  
  it "should have headings for each existing leading character" do
    %w(I S).each do |char|
      response.should have_tag("h2") do
        with_tag("a[link='#{char}']", char)
      end
    end
  end
end
