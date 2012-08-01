require 'spec_helper'

describe Admin::DashboardController do

  describe 'user access' do

    describe "GET 'index'" do      
      it "returns http success" do
        user = User.create(
          email: 'admin@example.com',
          password: 'secret',
          password_confirmation: 'secret'
        )
        session[:user_id] = user
        
        get 'index'
        response.should be_success
      end
    end
  end
  
  describe 'non-user access' do
    describe "GET 'index'" do
      it "redirects to the login form" do
        get 'index'
        response.should redirect_to login_url
      end
    end
  end
end
