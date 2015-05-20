class UsersController < ApplicationController
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
    @user = User.find(params[:id])
    if @user.update(user_params) && (@user == current_user)
      redirect_to user_path(@user), notice: "User Successfully Updated!"
    else
      flash[:alert] = "Invalid parameters, please try again."
      render :edit
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
