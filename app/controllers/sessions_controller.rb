require 'pry'
class SessionsController < ApplicationController
  def new
  end


  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to @user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end


  def oauth_create
    @user = User.find_or_create_by(provider_id: auth['uid']) do |u|
      u.provider = auth['provider']
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.provider_id = auth['uid']
      pwd = SecureRandom.hex 
      u.password = pwd 
      u.password_confirmation = pwd
      u.remember_digest = '0'
    end
    log_in(@user)
    redirect_to @user

  end 

  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
 
  def auth
    request.env['omniauth.auth']
  end


end
