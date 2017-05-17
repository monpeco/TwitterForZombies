require 'test_helper'

class StaticControllerTest < ActionController::TestCase
  test "should get tricks" do
    get :tricks
    assert_response :success
  end

end
