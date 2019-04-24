require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do 
    @user = users(:test_user_one)
    @other_user = users(:test_user_two)
  end 

  teardown do 
    @user = nil
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


end
