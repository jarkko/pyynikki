require 'spec_helper'

describe User do  
  before(:each) do
    @valid_attributes = {
      :login => "jarkko@jlaine.net",
      :password => "pw123",
      :password_confirmation => "pw123"
    }
    @user = User.create!(@valid_attributes)
  end
  
  subject { @user }
  
  it { should validate_uniqueness_of :login }

end
