require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should create user" do
    assert_difference('User.count') do
      post "/api/v1/users", params: { user: { name: @user.name } }, headers: {"CONTENT_TYPE" => "application/json"}, as: :json
    end

    assert_response 201
  end

end
