Given /^a logged in user$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^existing user$/ do
  @user = User.create!(:login => "jarkko@jlaine.net",
                       :password => "tiger",
                       :password_confirmation => "tiger")
end
