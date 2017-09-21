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

  def globe
    Search.destroy_all



    # Using Geocoder gem
    info = Geocoder.search( params[:address] )
    # Picking the first search that returns from an array

    unless info.empty?
      lat = info.first.latitude
      lng = info.first.longitude
    else
      lat = -33.862711
      lng = 151.213026
    end

    # Compiling string for the search as it has a certain format for geo searches
    geoCode = "Geocode:#{lat},#{lng},2km"

    # Connecting to Twitter's API and storing results in the variable @tweets
    @tweet_locations = []

    @tweets = $twitter.search("#{geoCode}", :result_type => "recent").take(200).collect do |tweet|

      # Pulling out the individual data we need
      @created_at = tweet.created_at.beginning_of_minute()
      @text = tweet.text
      @screen_name = tweet.user.screen_name
      @profile_image_url = tweet.user.profile_background_image_url
      @lat = tweet.geo.coordinates[0]
      @lng = tweet.geo.coordinates[1]


      unless tweet.geo.coordinates[0].nil?
        r = Random.new
        rand_number = r.rand(0.000100..0.000999)
        rand_number2 = r.rand(0.000100..0.000999)
        lat = tweet.geo.coordinates[0]
        lng = tweet.geo.coordinates[1]
        lat += rand_number
        lng += rand_number2
        lat_rand = lat.round(5)
        lng_rand = lng.round(6)
        t = Search.create :created_at => @created_at, :text => @text, :screen_name => @screen_name, :profile_image_url => @profile_image_url, :latitude => lat_rand, :longitude => lng_rand
        @tweet_locations << [t.text, t.latitude, t.longitude, t.id]

      end
      @searches = Search.all
    end
  end

  def lookup
    render json: @tweets
  end

  def data
    searches = Search.all
    respond_to do |format|
      format.html
      format.json { render :json => searches.to_json(:methods => :minutes_since_midnight) }
    end
  end
end
