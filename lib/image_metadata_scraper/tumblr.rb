# frozen_string_literal: true
require 'nokogiri'
require 'open-uri'

module ImageMetadataScraper
  module Tumblr
    def self.post(url)
      api_url = url.match /\A(?<blog>https?:\/\/.*tumblr.com)\/(post|image)\/(?<post_id>\d+)/ do |m|
        "#{m[:blog]}/api/read?id=#{m[:post_id]}"
      end
      xml = Nokogiri::XML(open(api_url))

      image_file_url = xml.at('//photo-url[@max-width="1280"]').content

      thumbnail_url = xml.at('//photo-url[@max-width="500"]').content

      artist_name = xml.at('//tumblelog').attr('name')

      canonical_page_url = xml.at('//post').attr('url-with-slug')

      { image_url: image_file_url, thumbnail_url: thumbnail_url, artist: artist_name, url: canonical_page_url }
    end
  end
end
