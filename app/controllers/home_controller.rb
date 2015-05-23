class HomeController < ApplicationController
  layout "landing"
  before_action :logged_in?

  def index
    @user = User.new
  end

  private

  def logged_in?
    if current_user.present?
      redirect_to reports_path
    end
  end

end
