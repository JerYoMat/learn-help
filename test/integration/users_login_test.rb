require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'login with valid information' do 
    @user = users(:test_user_one)
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email, password:"password1" } }
    assert_redirected_to user_path(@user)
  end 

end
