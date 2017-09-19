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

  def globe
    Search.destroy_all

    lat = params[:lat]
    lng = params[:lng]

    @lat = lat.to_f
    @lng = lng.to_f

    #compiling string for the search as it has a certain format for geo searches
    geoCode = "Geocode:#{lat},#{lng},2km"
    #connecting to twitters API and storing results in the variable @tweets
    @tweets = $twitter.search("#{geoCode}", :result_type => "recent").take(200).collect do |tweet|
    # {
    #   :created_at => tweet.created_at.beginning_of_minute,
    #   :text => tweet.text,
    #   :screen_name => tweet.user.screen_name,
    #   :profile_url => tweet.user.profile_background_image_url,
    #   :lat => tweet.geo.coordinates[0],
    #   :lng => tweet.geo.coordinates[1]
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
    unless tweet.geo.coordinates[0].nil?
      Search.create :created_at => @created_at, :text => @text, :screen_name => @screen_name, :profile_image_url => @profile_image_url, :lat => @lat, :lng => @lng
      end
    end

  end

  def home
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

  def locationPicker

    geocode_api_key = ENV['GEOCODING_API_KEY']

    address = "#{params[:hashtag]}"
    compliedAdress = address.gsub!(" ", "+")

    #using Google maps api to convert params into lat and lng coordinates
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{compliedAdress},+CA&key=#{geocode_api_key}"
    info = HTTParty.get url

    @infoResults = info["results"]


    # respond_to do |format|
    #   format.html
    #   format.json { render :json => info["results"]}
    # end

    # info["results"].each do |k|
    #   puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    #   puts "k = #{k}"
    #   puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    #   @k = k
    #
    # end
  end


end
