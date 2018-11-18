class UsersController < ApplicationController
  before_action :require_login
  def index
    @users = User.page param_page
    @nama = "TOBI"
  end

  def new
    @stores = Store.all
  end

  def create
    user = User.new user_params
    return redirect_to new_user_path if user.invalid?
    user.save!
    return redirect_to users_path
  end

  def edit
    return redirect_back_no_access_right unless params[:id].present?
    @user = User.find_by_id params[:id]
    return redirect_to stocks_path unless user.present?
  end

  def update
    return redirect_back_no_access_right unless params[:id].present?
    user = User.find_by_id params[:id]
    user.assign_attributes user_params
    user.save! if user.changed?
    return redirect_to users__path
  end

  private
    def user_params
      params.require(:user).permit(
        :name, :email, :password, :level, :phone, :sex, :store_id, :id_card, :address
      )
    end

    def param_page
      params[:page]
    end
end
