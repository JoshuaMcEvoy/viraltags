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
<<<<<<< HEAD
    @tweets =$twitter.search("#[blacklivesmatter]}", :result_type => "recent").take(1).collect do |tweet|
=======
    @tweets =$twitter.search("#[#{params}]", :result_type => "recent").take(3).collect do |tweet|
      tweet
    end
  end

  def lookup
    @tweets =$twitter.search("#[#{ params[:hashtag] }]", :result_type => "recent").take(3).collect do |tweet|
>>>>>>> 3a20a39105e38b81724d94fe1252ebe9db73bf25
      tweet
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
