module V1
  class UsersController < BaseController
    def_param_group :address do
      param :street, String, "Street name"
      param :number, Integer
      param :zip, String
    end

    def_param_group :user do
      param :user, Hash, :required => true, :action_aware => true do
        param :name, String, "Name of the user", :required => true
        param_group :address
      end
    end

    api!
    def index
      @users = User.all

      render json: @users
    end

    api!
    def show
      @user = User.find(params[:id])

      render json: @user
    end

    api!
    param_group :user
    def create
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    api!
    param_group :user
    def update
      @user = User.find(params[:id])

      if @user.update_attributes(user_params)
        head :no_content
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    api!
    def destroy
      @user = User.find(params[:id])
      @user.destroy

      head :no_content
    end

    private

    def user_params
      params.require(:user).permit(:name)
    end

  end
end
