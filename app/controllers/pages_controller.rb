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
    lat = info.first.latitude
    lng = info.first.longitude

    # Compiling string for the search as it has a certain format for geo searches
    geoCode = "Geocode:#{lat},#{lng},2km"
    # Connecting to Twitter's API and storing results in the variable @tweets
    @tweet_locations = []
    @tweets = $twitter.search("#{geoCode}", :result_type => "recent").take(200).collect do |tweet|

    # {
    #   :created_at => tweet.created_at.beginning_of_minute,
    #   :text => tweet.text,
    #   :screen_name => tweet.user.screen_name,
    #   :profile_url => tweet.user.profile_background_image_url,
    #   :lat => tweet.geo.coordinates[0],
    #   :lng => tweet.geo.coordinates[1]
    # }

      # Pulling out the individual data we need
      @created_at = tweet.created_at.beginning_of_minute()
      @text = tweet.text
      @screen_name = tweet.user.screen_name
      @profile_image_url = tweet.user.profile_background_image_url
      @lat = tweet.geo.coordinates[0]
      @lng = tweet.geo.coordinates[1]

      unless tweet.geo.coordinates[0].nil?
        t = Search.create :created_at => @created_at, :text => @text, :screen_name => @screen_name, :profile_image_url => @profile_image_url, :latitude => @lat, :longitude => @lng
        @tweet_locations << [t.text, t.latitude, t.longitude]
      end
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

  # def locationPicker
  #   geocode_api_key = ENV['GEOCODING_API_KEY']
  #   address = "#{params[:hashtag]}"
  #   compliedAdress = address.gsub!(" ", "+")
  #
  #   #using Google maps api to convert params into lat and lng coordinates
  #   url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{compliedAdress},+CA&key=#{geocode_api_key}"
  #   info = HTTParty.get url
  #
  #   @infoResults = info["results"]
  #
  # end
end
