require 'test_helper'

class TipsControllerTest < ActionDispatch::IntegrationTest
  setup do 
    @tip = tips(:test_tip_one)
    @user = users(:test_user_one)
    @new_tip= @user.tips.build(
      title: 'Controller Test',
      link:  'www.fin-coda.com',
      benefit: 'great for testing controller',
      tip_type: 'theory',
      topic_id: 1
    )
  end 
  teardown do 
    Rails.cache.clear 
  end 
  test 'should be valid' do
    assert @new_tip.valid?
  end 

  test "should redirect create when not logged in" do
    assert_no_difference 'Tip.count' do
      post tips_path, params: { 
        tip: {
          user_id: @user.id,
          title: @new_tip.title,
          link: @new_tip.link,
          benefit: @new_tip.benefit,
          tip_type: @new_tip.tip_type,
          topic_id: 1
        } 
      }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Tip.count' do
      delete tip_path(@tip)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong tip" do
    log_in_as(users(:test_user_one))
    tip = tips(:test_tip_user_two)
    assert_no_difference 'Tip.count' do
      delete tip_path(tip)
    end
    assert_redirected_to root_url
  end

end
