class StaticController < ApplicationController
  def tricks
  end
  
  def red
  end  
  
  def redman
    @category = Human.all
  end
end
