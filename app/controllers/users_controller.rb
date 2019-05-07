class UsersController < ApplicationController
  before_action :store_location, only: [:edit]
  before_action :logged_in_user, only: [:show, :index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :index]

  def show
    @user = User.find(params[:id])
    @tips = @user.tips.paginate(page: params[:page])
  end 

  def new
    @user = User.new
  end

  def index
    @users= User.all
  end 

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to learnHELP!'
      redirect_back_or(@user)
    else
      render 'new'
    end
  end



  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end 

  private

  def set_user
    @user = User.find(params[:id])
  end 

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
  def user_params
    params.require(:user).permit(
      :name, 
      :email, 
      :password,
      :password_confirmation,
      :provider,
      :provider_id,
      :bootcamp_name
    )
  end

end
