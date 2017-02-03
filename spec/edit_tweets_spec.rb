require 'spec_helper'

describe EditTweets do
  it 'has a version number' do
    expect(PostToHatena::VERSION).not_to be nil
  end

  describe '#fetch_tweets_between' do
    it 'fetches tweets between one day and another day' do
      tweets = EditTweets.fetch_tweets_between('2016/10/1', '2016/10/10')
      expect(tweets.length).to eq 7
    end
  end

  describe '#fetch_daily_tweets' do
    it 'fetches tweets of the day' do
      tweets = EditTweets.fetch_daily_tweets('2016/09/03')
      expect(tweets.length).to eq 3
      tweets = EditTweets.fetch_daily_tweets('2016/08/30')
      expect(tweets.length).to eq 2
      tweets = EditTweets.fetch_daily_tweets('2016/08/16')
      expect(tweets.length).to eq 3
      tweets = EditTweets.fetch_daily_tweets('2011/03/29')
      expect(tweets.length).to eq 1
      tweets = EditTweets.fetch_daily_tweets('2011/03/28')
      expect(tweets.length).to eq 0
    end
  end

  describe '#edit_tweets_for_hatena' do
    it 'edit tweets for hatena' do
      tweets = EditTweets.fetch_daily_tweets('2016/09/03')
      expect(EditTweets.edit_tweets_for_hatena(tweets)).not_to eq ''
    end
  end
  
  describe '#edit_last_month_tweets' do
    it 'fetches tweets of the last month' do
      tweets = EditTweets.fetch_last_month_tweets()
      expect(tweets.length).to eq 121
    end
  end
end
