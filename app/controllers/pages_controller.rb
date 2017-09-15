class PagesController < ApplicationController
  def home
      users = User.all

      respond_to do |format|
        format.html
        format.json { render :json => users.to_json(:include => :comments) }
    end
  end

  def show
    
  end
end
