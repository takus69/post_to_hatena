require 'spec_helper'

describe PostToHatena do
  it 'has a version number' do
    expect(PostToHatena::VERSION).not_to be nil
  end

  describe '#post_to_hatena' do
    it 'posts article to hatena' do
#      expect(PostToHatena.post_to_hatena('title', 'body', 'twitter', true)).to be_truthy
      expect(PostToHatena.post_to_hatena('title', '', 'twitter')).to be_falsey
    end
  end
  
  describe '#post_tweets' do
    it 'post tweets in the previous month' do
      expect(PostToHatena.post_tweets()).to be_truthy
    end
  end
  
  describe '#makeXml' do
    it 'make xml for hatena' do
      xml = "<?xml version='1.0' encoding='UTF-8'?><entry xmlns:app='http://www.w3.org/2007/app' xmlns='http://www.w3.org/2005/Atom'><title>タイトル</title><author><name>takus4649</name></author><content type='text/plain'>本文</content><category term='カテゴリ'/></entry>"
      expect(PostToHatena.makeXml("タイトル", "本文", "カテゴリ", false).to_s).to eq xml
    end
  end
end
