require "post_to_hatena/version"
require 'rexml/document'
require 'net/http'
require 'uri'

module PostToHatena
  def self.post_to_hatena(title, body, category, draft = false)
    return false if body.empty?

    hatena_id = ENV['HATENA_ID']
    blog_id = ENV['BLOG_ID']
    api_key = ENV['API_KEY']

    uri = URI.parse("https://blog.hatena.ne.jp/#{hatena_id}/#{blog_id}/atom/entry")

    doc = REXML::Document.new
    doc << REXML::XMLDecl.new('1.0', 'UTF-8')
    
    feed = doc.add_element('entry', {'xmlns' => 'http://www.w3.org/2005/Atom', 'xmlns:app' => 'http://www.w3.org/2007/app'})
    feed.add_element('title').add_text(title)
    feed.add_element('author').add_element('name').add_text('takus4649')
    feed.add_element('content', {'type' => 'text/plain'}).add_text(body)
    feed.add_element('category', {'term' => category})
    feed.add_element('app:control').add_element('app:draft').add_text('yes') if draft

    request = Net::HTTP::Post.new(uri.request_uri)
    request.basic_auth hatena_id, api_key
    request.body = doc.to_s

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    code   = ""
    messge = ""
    http.start do |h|
      response = h.request(request)
      code     = response.code
      message  = response.message
    end

    if code == "201"
      return true
    else
      p message
      return false
    end
  end
end
