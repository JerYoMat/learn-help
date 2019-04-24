
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


  def facebook_create
    @user = User.find_or_create_by(provider_id: auth['uid']) do |u|
      u.provider = 'facebook'
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.provider_id = auth['uid']
      pwd = SecureRandom.hex 
      u.password = pwd 
      u.password_confirmation = pwd
      user.remmember_digest = '0'
    end
    log_in(@user)
    redirect_to @user

  end 

  def github_create 
    #Github OmniAuth Implementation 
    
    @user = User.find_or_create_by(provider_id: auth['uid']) do |user|  
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["extra"]["raw_info"]["login"] 
      user.email = Faker::Internet.email
      pwd = SecureRandom.hex #To bypass validations for password set up in user model
      user.password = pwd 
      user.password_confirmation = pwd
      user.remmember_digest = '0'
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
