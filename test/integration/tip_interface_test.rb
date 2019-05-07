require 'test_helper'

class TipInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user_one)
    @new_tip= @user.tips.build(
      title: 'Controller Test',
      link:  'www.fin-cod3.com',
      benefit: 'great for testing',
      tip_type: 'theory',
      topic_id: 1
    )
  end

  test "tip interface" do
    log_in_as(@user)
    get root_path
    assert_no_difference 'Tip.count' do
      post tips_path, params: { tip: { title: "nada"} }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    assert_difference 'Tip.count', 1 do
      post tips_path, params: { 
        tip: { 
          title: @new_tip.title,
          link: @new_tip.link,
          benefit: @new_tip.benefit,
          tip_type: @new_tip.tip_type,
          topic_id: @new_tip.topic_id
      } 
    }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'a', text: 'delete'
    first_tip = @user.tips.paginate(page: 1).first
    assert_difference 'Tip.count', -1 do
      delete tip_path(first_tip)
    end
    # Visit different user (no delete links)
    get user_path(users(:test_user_two))
    assert_select 'a', text: 'delete', count: 0
  end 
end
