require 'post_to_hatena/version'
require 'twitter'
require 'rexml/document'
require 'net/http'
require 'uri'

module EditTweets
  def self.fetch_last_month_tweets(max_id="")
    day = Date.today.prev_month
    start_date = Date.new(day.year, day.month, 1)
    end_date = Date.new(day.year, day.month, -1)
    return fetch_tweets_between(start_date.to_s, end_date.to_s, max_id="")
  end
  
  def self.fetch_daily_tweets(date, max_id="")
    return fetch_tweets_between(date, date, max_id="")
  end

  def self.fetch_tweets_between(start_date, end_date, max_id="")
    client = twitter_client

    tweets_between = []
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)
    tweets = client.user_timeline(ENV['TWITTER_ID'], twitter_options(max_id))
    return [] if tweets.length == 1
    tweets.each do |tweet|
      next if tweet.id == max_id
      max_id = tweet.id
      if tweet.created_at.to_date > end_date
        next
      elsif tweet.created_at.to_date >= start_date
        tweets_between.push(tweet)
      else
        return tweets_between
      end
    end

    return tweets_between + fetch_tweets_between(start_date.to_s, end_date.to_s, max_id)
  end

  def self.edit_tweets_for_hatena(tweets)
    body = ""
    tweets.each do |tweet|
      body += "[" + tweet.uri + ":embed#" + tweet.full_text.inspect + "]\n"
    end
    body
  end

  private

    def self.twitter_options(max_id="")
      options = {include_rts: false}
      unless max_id == ""
        options[:max_id] = max_id
        options[:count]  = 200
      end
      options
    end
  
    def self.twitter_client
      client = Twitter::REST::Client.new do |config|
        config.consumer_key           = ENV['CONSUMER_KEY']
        config.consumer_secret        = ENV['CONSUMER_SECRET']
        config.access_token           = ENV['ACCESS_TOKEN']
        config.access_token_secret    = ENV['ACCESS_SECRET']
      end
    end
end
