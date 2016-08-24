class WeiboPagesController < ApplicationController
  def index
    @mblogs = Mblog.all
  end
  
end