require 'test_helper'

class UserTest < ActiveSupport::TestCase
  require 'test_helper'

  setup do
    @user = User.new(name: 'Example User', email: 'user@example.com',
    password: 'foobars', password_confirmation: 'foobars', bootcamp_student: true, has_graduated: true, camp_organization: 'flatiron')
  end


  test 'should be valid' do
    assert @user.valid?
  end

  test 'bootcamp_student should be present' do 
    @user.bootcamp_student = nil 
    assert_not @user.valid?
  end 

  test 'has_graduated should be present' do 
    @user.has_graduated = nil 
    assert_not @user.valid? 
  end 

  test 'camp_organization should be present' do 
    @user.camp_organization = nil 
    assert_not @user.valid?
  end 

  test 'name should be present' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '     '
    assert_not @user.valid?
  end

  test 'name should not be too long' do 
    @user.name = 'a'*256
    assert_not @user.valid? 
  end 

  test 'email should not be too long' do 
    @user.email = 'a'*246 + '.email.com'
    assert_not @user.valid? 
  end 

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[
      user@example.com 
      USER@foo.COM 
      A_US-ER@foo.bar.org
      first.last@foo.jp 
      alice+bob@baz.cn
      gg.g@g.g
    ]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, '#{valid_address.inspect} should be valid'
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[
      user@example,com 
      user_at_foo.org 
      user.name@example.
      foo@bar_baz.com 
      foo@bar+baz.com
    ]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, '#{invalid_address.inspect} should be invalid'
    end
  end


  test 'email address should be unique' do 
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end 

  test 'all email should be saved to db as lower case' do
    mixed_case_email = 'NoobSkool@NoOB.Com'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end 

  test 'password should be present (nonblank)' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

end
