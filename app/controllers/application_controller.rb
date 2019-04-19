class ApplicationController < ActionController::Base
  def start
    render html: "hello world"
  end 
end
