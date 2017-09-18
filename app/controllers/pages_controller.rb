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

  def data
    searches = Search.all
    respond_to do |format|
      format.html
      format.json { render :json => searches.to_json }
    end
  end

  def lookup

    @tweets = $twitter.search("#[#{ params[:hashtag] }]", :result_type => "recent").take(10).collect do |tweet|

    # {
    #   :created_at => tweet.created_at,
    #   :text => tweet.text,
    #   :screen_name => tweet.user.screen_name,
    #   :profile_url => tweet.user.profile_background_image_url
    # }

      @created_at = tweet.created_at.beginning_of_minute()
      @text = tweet.text
      @screen_name = tweet.user.screen_name
      @profile_image_url = tweet.user.profile_background_image_url



    end
    # render json: @tweets
    Search.destroy_all
    Search.create :created_at => @created_at, :text => @text, :screen_name => @screen_name, :profile_image_url => @profile_image_url


  end

end
