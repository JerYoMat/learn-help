class StaticPagesController < ApplicationController
  def home
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
