require "test_helper"

class User::GroupCombinationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_group_combinations_create_url
    assert_response :success
  end

  test "should get destroy" do
    get user_group_combinations_destroy_url
    assert_response :success
  end
end
