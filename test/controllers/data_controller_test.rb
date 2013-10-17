require 'test_helper'

class DataControllerTest < ActionController::TestCase
  test "should get seed" do
    get :seed
    assert_response :success
  end

end
