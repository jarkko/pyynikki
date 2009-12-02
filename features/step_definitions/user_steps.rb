Given /^a logged in user$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^existing user$/ do
  @user = User.create!(:email => "jarkko@jlaine.net",
                       :password => "tiger")
end
