class PagesController < ApplicationController
  def home
  #   TweetStream.configure do |config|
  #     config.consumer_key       = 'NGqfbpaGwt7SeUGrcKeThpewj'
  #     config.consumer_secret    = 'fN0w0qgrQmQBaYWnnmXBCcOwGaWcDkwk5qxP5dCVYXjpL3PMzG'
  #     config.oauth_token        = '908491196133027840-v0TeCDBFOeQe60EzXztc6dwAMB4F3IY'
  #     config.oauth_token_secret = '3I25gFQVZYQI1wMA4tJQwmMKd6vtoGZfFF2DLS58QUrdr'
  #     config.auth_method        = :oauth
  #   end
  #
  #   TweetStream::Client.new.track('jaehee') do |status|
  #     puts "#{status.text}"
  #   end

    # @statuses = []
    #
    # TweetStream::Client.new.track('trump') do |status, client|
    #   # puts "#{status.text}"
    #
    #   @statuses << status
    #   client.stop if @statuses.size >= 10
    #   puts "#{@statuses}"
    #   puts "#{status}"
    #
    #
    # end

      users = User.all
    @result = $twitter.user_timeline("realDonaldTrump")
      respond_to do |format|
        format.html
        format.json { render :json => users.to_json(:include => :comments) }

      end
  end

  def show
  end
end
