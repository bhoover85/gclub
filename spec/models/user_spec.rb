require 'spec_helper'
require 'rspec/its'

describe User do
  
  before do
    @user = User.new(email: "user@example.com",
                     password: "foobar1234", password_confirmation: "foobar1234")
  end

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

end
