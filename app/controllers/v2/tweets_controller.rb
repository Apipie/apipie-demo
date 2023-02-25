module V2
  class TweetsController < BaseController
    before_action :find_user

    api!
    def index
      @tweets = @user.tweets.all

      render json: @tweets
    end

    api!
    def show
      @tweet = @user.tweets.find(params[:id])

      render json: @tweet
    end

    api!
    param :tweet, Hash do
      param :scheduled_at, :undef
      param :sent, :bool
      param :text, :undef
      param :user_id, :number
    end
    def create
      @tweet = @user.tweets.new(tweet_params)

      if @tweet.save
        render json: @tweet, status: :created, location: [@user, @tweet]
      else
        render json: @tweet.errors, status: :unprocessable_entity
      end
    end

    api!
    param :tweet, Hash do
      param :scheduled_at, :undef
      param :sent, :bool
      param :text, :undef
      param :user_id, :number
    end
    def update
      @tweet = @user.tweets.find(params[:id])

      if @tweet.update_attributes(tweet_params)
        head :no_content
      else
        render json: @tweet.errors, status: :unprocessable_entity
      end
    end

    api!
    def destroy
      @tweet = @user.tweets.find(params[:id])
      @tweet.destroy

      head :no_content
    end

    private

    def find_user
      @user = User.find_by_id(params[:user_id])
    end

    def tweet_params
      params.require(:tweet).permit(:scheduled_at, :sent, :text, :user_id)
    end
  end
end
