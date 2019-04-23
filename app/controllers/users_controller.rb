class UsersController < ApplicationController
  

  def show
    @user = User.find(params[:id])
  end 

  def new
  end

  def index 
  end 

  def create
  end 

  def edit
  end

  def update
  end

  def destroy
  end 

end
