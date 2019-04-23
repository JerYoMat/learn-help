ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  fixtures :all
  include ApplicationHelper
  def is_logged_in?
    !session[:user_id].nil?
  end
  def log_in_as(user)
    session[:user_id] = user.id
  end
end

class ActionDispatch::IntegrationTest
  # Log in as a particular user.
  def log_in_as(user, password: 'password1', remember_me: '1')
    post login_path, params: {
      session: {
        email: user.email,
        password: password,
        remember_me: remember_me 
        } 
      }
  end

  def forget(user)
    user.update_attribute(:remember_digest, nil)
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end 
end
