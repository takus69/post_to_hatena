require 'spec_helper'

describe PostToHatena do
  describe '#post_tweets' do
    it 'post tweets in the previous month' do
      expect(PostToHatena.post_tweets()).to be_truthy
    end
  end
end
