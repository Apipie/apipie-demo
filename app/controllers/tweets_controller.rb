class TweetsController < ApplicationController
  before_filter :find_user
  
  def index
    @tweets = @user.tweets.all

    render json: @tweets
  end

  def show
    @tweet = @user.tweets.find(params[:id])

    render json: @tweet
  end

  def create
    @tweet = @user.tweets.new(params[:tweet])

    if @tweet.save
      render json: @tweet, status: :created, location: [@user, @tweet]
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  def update
    @tweet = @user.tweets.find(params[:id])

    if @tweet.update_attributes(params[:tweet])
      head :no_content
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @tweet = @user.tweets.find(params[:id])
    @tweet.destroy

    head :no_content
  end

  private

  def find_user
    @user = User.find_by_id(params[:user_id])    
  end
end
