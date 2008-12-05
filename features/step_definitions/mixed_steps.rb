
Given /I am on the new frooble page/ do
  visits "/froobles/new"
end

Given /there are (\d+) froobles/ do |n|
  Frooble.transaction do
    Frooble.destroy_all
    n.to_i.times do |n|
      Frooble.create! :name => "Frooble #{n}"
    end
  end
end

When /I delete the first frooble/ do
  visits froobles_url
  clicks_link "Destroy"
end

Then /there should be (\d+) froobles left/ do |n|
  Frooble.count.should == n.to_i
  response.should have_tag("table tr", n.to_i + 1) # There is a header row too
end

###

Then /^I should see a '(.*)' link/ do |text|
  response.should have_tag('a', text)
end

Then /^I should not see a '(.*)' link/ do |text|
  response.should_not have_tag('a', text)
end

Then /^I should stay on the login page$/ do
  response.should_not be_success
end

###

When "clicks on '$link'" do |link|
  clicks_link link
end

When "fills in $field with '$value'" do |field, value|
  fills_in field, :with => value
end  

When "selects $field as '$option'" do |field, option|
  selects option, :from => field
end

When "checks $checkbox" do |checkbox|
  checks checkbox
end

When "clicks the '$button' button" do |button|
  clicks_button button
end
    
