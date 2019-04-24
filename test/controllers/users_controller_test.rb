require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do 
    @user = users(:test_user_one)
    @other_user = users(:test_user_two)
  end 

  teardown do 
    Rails.cache.clear
  end 
  
  test 'should get new' do
    get signup_path
    assert_response :success
  end

  test 'redirect away from edit when not logged in' do
    get edit_user_path(@user)
    assert flash[:danger],'Please log in.'
    assert_redirected_to login_url
  end 

  test 'redirect away from update when not logged in' do
    patch user_path(@user), params: {
      user: { 
        name: @user.name,
        email: @user.email 
      } 
    }
    assert flash[:danger],'Please log in.'
    assert_redirected_to login_url
  end 

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: {
      user: { 
        name: @user.name,
        email: @user.email
      }
    }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test 'adding admin privileges is restricted' do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
      user: { 
        password:'password1',
        password_confirmation: 'password1',
        admin: true
        }
    }
    assert_not @other_user.reload.admin?
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end


end
