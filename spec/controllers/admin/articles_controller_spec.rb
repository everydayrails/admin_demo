# This is a simplified controller spec, mainly illustrating how one might 
# ensure that the controller's methods are properly locked down from
# unauthorized access.

require 'spec_helper'

describe Admin::ArticlesController do
  describe 'user access' do

    before :each do
      user = User.create(
        email: 'admin@example.com',
        password: 'secret',
        password_confirmation: 'secret'
      )
      session[:user_id] = user
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
          post :create, article: FactoryGirl.attributes_for(:article)
        }.to change(Article, :count).by(1)
      end
    end
    
    describe "GET :edit" do
      it "returns http success" do
        get :edit, id: FactoryGirl.create(:article)
        response.should be_successful
      end
    end
    
    describe "PUT :update" do
      it "updates the article" do
        article = FactoryGirl.create(:article, name: 'Poor Title')
        put :update, id: article,
          article: FactoryGirl.attributes_for(:article, name: 'Better Title')
        article.reload
        article.name.should eq 'Better Title'
      end
    end
    
    describe "DELETE :destroy" do
      it "deletes the article" do
        article = FactoryGirl.create(:article)
        expect{
          delete :destroy, id: article
        }.to change(Article, :count).by(-1)
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
        post :create, article: FactoryGirl.attributes_for(:article)
        response.should redirect_to login_url
      end
    end
    
    describe "GET :edit" do
      it "redirects to the login form" do
        get :edit, id: FactoryGirl.create(:article)
        response.should redirect_to login_url
      end
    end
    
    describe "PUT :update" do
      it "redirects to the login form" do
        put :update, id: FactoryGirl.create(:article),
          article: FactoryGirl.attributes_for(:article)
        response.should redirect_to login_url
      end
    end
    
    describe "DELETE :destroy" do
      it "redirects to the login form" do
        delete :destroy, id: FactoryGirl.create(:article)
        response.should redirect_to login_url
      end
    end
  end
end
