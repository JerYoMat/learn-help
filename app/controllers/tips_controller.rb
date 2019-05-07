class TipsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @tip = current_user.tips.build(tip_params)
    if @tip.save
      flash[:success] = "tip created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @tip.destroy 
    flash[:success] = 'Tip has been deleted'
    redirect_to request.referrer || root_url
  end

  private 

  def tip_params
    params.require(:tip).permit(:title, :link, :tip_type, :benefit, :topic_id, :picture)
  end

  def correct_user
    @tip = current_user.tips.find_by(id: params[:id])
    redirect_to root_url if @tip.nil?
  end
end
