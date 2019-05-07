require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  setup do
    @relationship = Relationship.new(
      follower_id: users(:test_user_one).id,
      followed_id: users(:test_user_two).id
    )
  end

  test "should be valid" do
    assert @relationship.valid?
  end

end
