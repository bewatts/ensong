class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  serialization_scope :current_user
end
