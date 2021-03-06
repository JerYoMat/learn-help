require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "learnHELP"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get code of conduct" do
    get code_of_conduct_path
    assert_response :success
    assert_select "title", "Code of Conduct | #{@base_title}"
  end
  

end
