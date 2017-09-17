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
    # @tweets =$twitter.search("#[#{params}]", :result_type => "recent").take(10).collect do |tweet|
    #   tweet
    # end
  end

  def lookup
    @tweets =$twitter.search("#[#{ params[:hashtag] }]", :result_type => "recent").take(20).collect do |tweet|
      {
        :created_at => tweet.created_at,
        :text => tweet.text
      }
    end
    render json: @tweets
  end

  def data
    respond_to do |format|
      format.json {
        render :json => [1,2,3,4,5]
      }
    end
  end
end
