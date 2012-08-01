class Admin::DashboardController < ApplicationController
  
  before_filter :authorize
  
  def index
  end
end
