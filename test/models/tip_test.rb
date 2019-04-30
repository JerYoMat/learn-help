require 'test_helper'

class TipTest < ActiveSupport::TestCase
  setup do 
    @user = users(:test_user_one)
    @tip = @user.tips.build(
      title: "test title",
      link: "www.railstutorial.org",
      benefit: "build full rails application while slowly transitioning  to a tdd approach to adding new features.",
      topic_id: 1 
    )
  end 

  test 'should be valid' do 
    assert @tip.valid? 
  end 
  
  test 'link should be present' do
    @tip.link = ' '
    assert_not @tip.valid? 
  end 

  test 'benefit should be present' do 
    @tip.benefit = ' '
    assert_not @tip.valid? 
  end 

  test 'has a topic' do 
    @tip.topic_id = nil 
    assert_not @tip.valid? 
  end 

  test 'has a owner' do 
    @tip.user_id = nil 
    assert_not @tip.valid? 
  end 

end
