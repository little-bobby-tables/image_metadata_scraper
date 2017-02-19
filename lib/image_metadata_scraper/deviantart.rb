# frozen_string_literal: true
require 'nokogiri'
require 'net/http'

module ImageMetadataScraper
  module DeviantArt
    def self.post(url)
      response = URI(url).try do |uri|
        Net::HTTP.new(uri.host).get(uri.request_uri, { 'Cookie' => 'agegate_state=1' })
      end
      page = Nokogiri::HTML(response.body)

      # Image file URL: downloads enabled
      image_file_url = page.at('a.dev-page-download')&.attr('href')
      image_file_url &&= _follow_download_url(image_file_url, response)

      # Image file URL: downloads disabled
      image_file_url ||= page.at('.dev-view-deviation img.dev-content-full')&.attr('src')

      artist_name = page.at('.dev-title-container .username').content

      canonical_page_url = page.at('meta[property="og:url"]')&.attr('content')

      { image_url: image_file_url, artist: artist_name, url: canonical_page_url }
    end

    def self.direct_link(url)
      # Direct links have the fav.me shortcode as a part of the URL, we just need to grab that.
      shortcode = url.match(/-(.+)\..+\z/)[1]
      url = "http://fav.me/#{shortcode}"
      post(ImageMetadataScraper.redirect_from(url))
    end

    def self._follow_download_url(url, previous_request)
      cookies = previous_request['set-cookie'].split(';').first
      uri = URI(url)
      Net::HTTP.new(uri.host).head(uri.request_uri, { 'Cookie' => cookies })['location']
    end
  end
end
