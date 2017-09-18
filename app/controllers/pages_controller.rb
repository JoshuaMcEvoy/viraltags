class PagesController < ApplicationController
  def index

  end

  def show
    users = User.all
    respond_to do |format|
      format.html
      format.json { render :json => users.to_json(:include => :comments) }
    end
  end

  def home

  end

  def lookup
    @tweets =$twitter.search("#[#{ params[:hashtag] }]", :result_type => "recent").take(100).collect do |tweet|
    {
      :created_at => tweet.created_at,
      :text => tweet.text,
      # :screen_name => tweet.user.screen_name,
      # :profile_url => tweet.user.profile_background_image_url
    }



    end
  end

  def data
    respond_to do |format|
      format.json {
        render :json => [1,2,3,4,5]
      }
    end
  end
end
