require 'spec_helper'

describe 'site administration' do
  describe 'dashboard access' do
    it "accesses the dashboard" do
      FactoryGirl.create(:user,
        email: 'user@example.com',
        password: 'secret'
      )
  
      visit root_path
      click_link 'Log In'
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'secret'
      click_button 'Log In'
    
      current_path.should eq admin_path
      within 'h1' do
        page.should have_content 'Administration'
      end
      page.should have_content 'Manage Users'
      page.should have_content 'Manage Articles'
    end
  
    it "is denied access when not logged in" do
      visit admin_path

      current_path.should eq login_path
      within 'h1' do
        page.should have_content 'Please Log In'
      end
    end
  end
  
  describe 'article management' do
    before :each do
      user = FactoryGirl.create(:user)
      sign_in user
    end

    it "adds an article" do
      click_link 'Manage Articles'
      current_path.should eq admin_articles_path
      
      expect{
        click_link 'New Article'
        fill_in 'Name', with: 'My favorite web framework'
        fill_in 'Body', with: 'Rails is great!'
        click_button 'Create Article'
      }.to change(Article, :count).by(1)
      
      current_path.should eq admin_articles_path
      page.should have_content 'My favorite web framework'
    end
    
    it "edits an article" do
      article = FactoryGirl.create(:article,
        name: '2 Ruby frameworks',
        body: 'Rails and Sinatra')
      
      click_link 'Manage Articles'
      click_link 'Edit'
      fill_in 'Name', with: 'A tale of two frameworks'
      fill_in 'Body', with: 'Rails and Sinatra are both very useful.'
      click_button 'Update Article'

      current_path.should eq admin_articles_path
      page.should have_content 'A tale of two frameworks'
      
      article.reload
      article.name.should eq 'A tale of two frameworks'
      article.body.should eq 'Rails and Sinatra are both very useful.'
    end
    
    it "shows an article" do
      article = FactoryGirl.create(:article,
        name: '2 testing frameworks',
        body: 'RSpec and MiniTest')
      
      click_link 'Manage Articles'
      click_link 'Show'
      
      current_path.should eq admin_article_path(article)
      page.should have_content '2 testing frameworks'
      page.should have_content 'RSpec and MiniTest'
    end
    
    it "deletes an article" do
      article = FactoryGirl.create(:article,
        name: '2 Ruby frameworks')
              
      click_link 'Manage Articles'
      
      expect{
        click_link 'Destroy'
      }.to change(Article, :count).by(-1)

      current_path.should eq admin_articles_path
      page.should_not have_content '2 Ruby frameworks'
    end
  end  
  
  describe 'user management' do
    before :each do
      user = FactoryGirl.create(:user)
      sign_in user
    end
    
    it "adds a user" do
      click_link 'Manage Users'
      current_path.should eq admin_users_path
      
      expect{
        click_link 'New User'
        fill_in 'Email', with: 'aaron@everydayrails.com'
        fill_in 'Password', with: 'secret'
        fill_in 'Password confirmation', with: 'secret'
        click_button 'Create User'
      }.to change(User, :count).by(1)
      
      current_path.should eq admin_users_path
      page.should have_content 'aaron@everydayrails.com'
    end
  end
  
end