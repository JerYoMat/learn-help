require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  setup do 
    @topic = topics(:test_topic_one)
  end 

  test 'should be valid' do 
    assert @topic.valid? 
  end 

  test 'has course order' do 
    @topic.course_order = nil 
    assert_not @topic.valid? 
  end 

  test 'has a course name' do 
    @topic.course_name = nil 
    assert_not @topic.valid? 
  end 

  test 'hase a course version' do 
    @topic.course_version = nil 
    assert_not @topic.valid?
  end 
end
