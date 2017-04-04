class ArticlesController < ApplicationController
  def index
    @date = Date.today
  end
  
  def new
    redirect_to  articles_alternative_path
  end  
end
