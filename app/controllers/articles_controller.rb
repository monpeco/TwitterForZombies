class ArticlesController < ApplicationController
  def index
    @date = Date.today
  end
  
  def new
  end  
end
