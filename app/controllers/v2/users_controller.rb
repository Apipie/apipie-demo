module V2
  class UsersController < BaseController
    api :GET, "/v2/users", "List users"
    def index
      @users = User.all

      render json: @users
    end

    api :GET, "/v2/users/:id", "Show an user"
    def show
      @user = User.find(params[:id])

      render json: @user
    end

    api :POST, "/v2/users", "Create an user"
    param_group :user, V1::UsersController
    def create
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    api :PUT, "/v2/users/:id", "Update an user"
    param_group :user, V1::UsersController
    def update
      @user = User.find(params[:id])

      if @user.update(user_params)
        head :no_content
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    api :DELETE, "/v2/users/:id", "Destroy an user"
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
