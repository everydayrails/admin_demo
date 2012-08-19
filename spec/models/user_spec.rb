require 'spec_helper'

describe User do
  it "accepts a correctly-formatted email address" do
    FactoryGirl.build(:user, email: 'correct@gmail.com').should be_valid
  end
  
  it "rejects an incorrectly-formatted email address" do
    FactoryGirl.build(:user, email: 'correct@gmail').should_not be_valid    
  end
end
