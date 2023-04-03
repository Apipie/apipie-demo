require 'test_helper'

module V2
  class UsersControllerTest < ActionController::TestCase
    setup do
      @user = users(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:users)
    end

    test "should create user" do
      assert_difference('User.count') do
        post :create, params: { user: { name: @user.name } }
      end

      assert_response 201
    end

    test "should show user" do
      get :show, params: { id: @user.id }
      assert_response :success
    end

    test "should update user" do
      put :update, params: { id: @user.id, user: { name: @user.name } }
      assert_response 204
    end

    test "should destroy user" do
      assert_difference('User.count', -1) do
        delete :destroy, params: { id: @user }
      end

      assert_response 204
    end
  end
end
