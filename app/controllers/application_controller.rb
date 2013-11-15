class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include ApplicationHelper
  serialization_scope :current_user
  
  before_filter :check_browser
end
