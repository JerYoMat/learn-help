class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @tip = current_user.tips.build 
      @feed_items = current_user.feed.paginate(page: params[:page])
    end 
  end

  def about
  end

  def code_of_conduct
  end   

  def credits
  end 

  def help
  end 

  def contact 
  end 

  def acme_challenge1
    render 'static_pages/ssl_challenge_1', layout: false
  end 

end
