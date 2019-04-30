require 'test_helper'

class TipRatingTest < ActiveSupport::TestCase
  setup do 
    @user = users(:test_user_one)
    @user.password = 'password1'
    @user.password_confirmation = 'password1'
    @other_user = users(:test_user_two)
    @other_user.password = 'password1'
    @other_user.password_confirmation = 'password1'
    @tip = tips(:test_tip_one)
    @other_tip = tips(:test_tip_two)
    @tip_rating = @other_user.tip_ratings.build(
      tip_id: @tip.id,
      good_tip: true
    )
  end 

  test 'should be valid ' do 
    assert @tip_rating.valid? 
  end 

  test 'should have a user' do 
    @tip_rating.user_id = nil 
    assert_not @tip_rating.valid? 
  end 

  test 'should have a tip' do 
    @tip_rating.tip_id = nil 
    assert_not @tip_rating.valid? 
  end 

  test 'should have a rating value' do 
    @tip_rating.good_tip = nil 
    assert_not @tip_rating.valid? 
  end 


  test 'user cannot rate same tip twice' do 
    duplicate_rating = @tip_rating.dup
    @tip_rating.save
    assert_not duplicate_rating.valid?
  end 





end
