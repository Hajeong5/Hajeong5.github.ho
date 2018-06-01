require 'test_helper'

class OptionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get option_index_url
    assert_response :success
  end

end
