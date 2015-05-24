class SessionsController < ApplicationController
  layout "user"

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to reports_path, notice: "Logged in!"
    else
      flash.now[:alert] = "Incorrect Login Info! Have you Signed Up? #{view_context.link_to 'Click Here to create an account.', new_user_path}".html_safe
      if @user == nil
        @user = User.new
      end
      # redirect_to new_session_path
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You Have Successfully Logged Out"
  end

end
