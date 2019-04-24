require 'test_helper'

class FriendlyForwardingTest < ActionDispatch::IntegrationTest
  setup do 
    @user = users(:test_user_one)
  end 
  teardown do 
    log_out(@user)
    @user = nil 
    
  end 

  test 'user edit with friendly forwarding' do 
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    assert_template 'users/show'
  end 

end
