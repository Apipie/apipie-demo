module V2
  class TweetsController < BaseController
    before_filter :find_user

    # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
    api :GET, "/v2/users/:user_id/tweets", "List tweets"
    def index
      @tweets = @user.tweets.all

      render json: @tweets
    end

    # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
    api :GET, "/v2/users/:user_id/tweets/:id", "Show a tweet"
    def show
      @tweet = @user.tweets.find(params[:id])

      render json: @tweet
    end

    # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
    api :POST, "/v2/users/:user_id/tweets", "Create a tweet"
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

    # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
    api :PUT, "/v2/users/:user_id/tweets/:id", "Update a tweet"
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

    # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
    api :DELETE, "/v2/users/:user_id/tweets/:id", "Destroy a tweet"
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
