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

    api :GET, "/users", "List users"
    def index
      @users = User.all

      render json: @users
    end

    api :GET, "/users/:id", "Show an user"
    def show
      @user = User.find(params[:id])

      render json: @user
    end

    api :POST, "/users", "Create an user"
    param_group :user
    def create
      @user = User.new(params[:user])

      if @user.save
        render json: @user, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    api :PUT, "/users/:id", "Update an user"
    param_group :user
    def update
      @user = User.find(params[:id])

      if @user.update_attributes(params[:user])
        head :no_content
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    api :DELETE, "/users/:id", "Destroy an user"
    def destroy
      @user = User.find(params[:id])
      @user.destroy

      head :no_content
    end
  end
end
