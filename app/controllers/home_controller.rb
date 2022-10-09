class HomeController < ApplicationController
  def index
    if !user_signed_in?
      @q = Album.published.where(publish: true).ransack(params[:q])
      @albums = @q.result.includes(:tags)
    else
      redirect_to '/albums'
    end
  end
  
  def search
    if !user_signed_in?
      index
      render :index
    else 
      redirect_to '/albums'
    end
  end
end






