# This is a simplified controller spec, mainly illustrating how one might 
# ensure that the controller's methods are properly locked down from
# unauthorized access.

require 'spec_helper'

describe Admin::UsersController do
  describe 'user access' do

    before :each do
      user = User.create(
        email: 'admin@example.com',
        password: 'secret',
        password_confirmation: 'secret'
      )
      set_user_session user
    end

    describe "GET :index" do      
      it "returns http success" do        
        get :index
        response.should be_success
      end
    end
    
    describe "GET 'new" do
      it "returns http success" do        
        get :new
        response.should be_success
      end
    end
    
    describe "POST :create" do
      it "adds the article" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User, :count).by(1)
      end
    end
  end
  
  describe 'non-user access' do
    describe "GET :index" do
      it "redirects to the login form" do
        get :index
        response.should redirect_to login_url
      end
    end
    
    describe "GET :new" do
      it "redirects to the login form" do        
        get :new
        response.should redirect_to login_url
      end
    end

    describe "POST :create" do
      it "redirects to the login form" do
        post :create, article: FactoryGirl.attributes_for(:user)
        response.should redirect_to login_url
      end
    end
  end
end
