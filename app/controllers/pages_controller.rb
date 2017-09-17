class PagesController < ApplicationController

  def show
    users = User.all
    respond_to do |format|
      format.html
      format.json { render :json => users.to_json(:include => :comments) }
    end
  end

  def home
    @tweets =$twitter.search("#[blacklivesmatter]}", :result_type => "recent").take(1).collect do |tweet|
      tweet
    end
  end
end
