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
end
