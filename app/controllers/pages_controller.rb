class PagesController < ApplicationController
  def home
      user = User.all
      render :json => user.to_json(:include => :comments)
  end
end
