class UsersController < ApplicationController
  layout "user"
  before_action :authenticate_user!, only: [:update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to reports_path, notice: "Successfully Registered"
    else
      flash[:alert] = "Error creating account, please try again."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "User Successfully Updated!"
    else
      flash[:alert] = "Invalid parameters, please try again."
      render :edit
    end
  end

  def destroy
    @user = current_user
    if @user.destroy
      redirect_to root_path, notice: "User account deleted."
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
