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
    Search.destroy_all

    # Geocode:-33.821008,151.192018,Twitter%20HQ,2500km
    # geocode_api_key = ENV ['GEOCODING_API_KEY']

    #taking params and compiling string together with +
    address = "#{params[:hashtag]}"
    compliedAdress = address.gsub!(" ", "+")

    # raise 'hell'

    #using Google maps api to convert params into lat and lng coordinates
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{compliedAdress},+CA&key=AIzaSyCFxZqBX90SQYfICqylTVVhZxWFE3oQPfc"
    info = HTTParty.get url



    #Googles API returns multiple results with varying accuracy, this will return the first result in the array
    lat = info["results"][0]["geometry"]["location"]["lat"]
    lng = info["results"][0]["geometry"]["location"]["lng"]

    # raise 'hell'

    #compiling string for the search as it has a certain format for geo searches
    geoCode = "Geocode:#{lat},#{lng},2km"

    #connecting to twitters API and storing results in the variable @tweets
    @tweets = $twitter.search("#{geoCode}", :result_type => "recent").take(200).collect do |tweet|
    # {
    #   :created_at => tweet.created_at,
    #   :text => tweet.text,
    #   :screen_name => tweet.user.screen_name,
    #   :profile_url => tweet.user.profile_background_image_url
    # }

      #pulling out the individual data we need
      @created_at = tweet.created_at.beginning_of_minute()
      @text = tweet.text
      @screen_name = tweet.user.screen_name
      @profile_image_url = tweet.user.profile_background_image_url
      @lat = tweet.geo.coordinates[0]
      @lng = tweet.geo.coordinates[1]

      # tweet.created_at


    #saving the data to the database to be served in json format so D3 can utilise it
    Search.create :created_at => @created_at, :text => @text, :screen_name => @screen_name, :profile_image_url => @profile_image_url, :lat => @lat, :lng => @lng
    end
    # render json: @tweets

  end

  def data
    searches = Search.all
    respond_to do |format|
      format.html
      format.json { render :json => searches.to_json(:methods => :minutes_since_midnight) }
    end
  end
end
