class UsersController < ApplicationController
  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
  api :GET, "/users", "List users"
  def index
    @users = User.all

    render json: @users
  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
  api :GET, "/users/:id", "Show an user"
  def show
    @user = User.find(params[:id])

    render json: @user
  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
  api :POST, "/users", "Create an user"
  param :user, Hash do
    param :name, :undef
  end
  def create
    @user = User.new(params[:user])

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
  api :PUT, "/users/:id", "Update an user"
  param :user, Hash do
    param :name, :undef
  end
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
  api :DELETE, "/users/:id", "Destroy an user"
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    head :no_content
  end
end
