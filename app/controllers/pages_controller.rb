class PagesController < ApplicationController
  def home
    # TweetStream.configure do |config|
    #   config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
    #   config.consumer_secret = ENV['TWITTER_SECRET_KEY']
    #   config.access_token = ENV['TWITTER_ACCESS_TOKEN']
    #   config.access_token_secret = ENV['TWITTER_SECRET_TOKEN']
    # end
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

      respond_to do |format|
        format.html
        format.json { render :json => users.to_json(:include => :comments) }

      end
  end

  def show

  end
end
