require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should create user" do
    assert_difference('User.count') do
      post "/users", {user: { name: @user.name }}.to_json, {"CONTENT_TYPE" => "application/json"}
    end

    assert_response 201
  end

end
