class ArticlesController < ApplicationController
  def index
    @date = Date.today
  end
  
  def new
    flash[:notice] = 'This is a redirect message!!!'
    redirect_to  articles_alternative_path
  end  
end
