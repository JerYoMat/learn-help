require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:test_user_one)
    log_in_as(@user)
  end 
  teardown do 
    Rails.cache.clear
  end 
  
  test 'user edit with friendly forwarding' do 
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
  end 

  test 'unsuccessful edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {
      user: { 
        name:  '',
        email: 'foo@invalid',
        password:'foo',
        password_confirmation: 'bar' 
      } 
    }
    assert_template 'users/edit'
    assert_select 'div.alert', text: 'The form contains 5 errors.'
  end

  test 'successful edit' do 
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {
      user: { 
        name:  'My new name',
        email: 'foo@valid.com',
        password:'foobars',                
        password_confirmation: 'foobars' 
      } 
    }
    assert_not flash.empty?
    assert_redirected_to @user 
    @user.reload 
    assert_equal('My new name', @user.name)
    assert_equal('foo@valid.com', @user.email)
  end 
end
