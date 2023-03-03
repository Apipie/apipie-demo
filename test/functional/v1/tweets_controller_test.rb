require 'test_helper'

module V1
  class TweetsControllerTest < ActionController::TestCase
    setup do
      @user = users(:one)
      @tweet = tweets(:one)
      @tweet.update(user_id: @user.id)
    end

    test "should get index" do
      get :index, params: { user_id: @user.id }
      assert_response :success
      assert_not_nil assigns(:tweets)
    end

    test "should create tweet" do
      assert_difference('Tweet.count') do
        post :create, params: { user_id: @user.id, tweet: { scheduled_at: @tweet.scheduled_at, sent: @tweet.sent, text: @tweet.text, user_id: @tweet.user_id } }
      end

      assert_response 201
    end

    test "should show tweet" do
      get :show, params: { user_id: @user.id, id: @tweet.id }
      assert_response :success
    end

    test "should update tweet" do
      put :update, params: { user_id: @user.id, id: @tweet.id, tweet: { scheduled_at: @tweet.scheduled_at, sent: @tweet.sent, text: @tweet.text, user_id: @tweet.user_id } }
      assert_response 204
    end

    test "should destroy tweet" do
      assert_difference('Tweet.count', -1) do
        delete :destroy, params: { user_id: @user.id, id: @tweet }
      end

      assert_response 204
    end
  end
end
