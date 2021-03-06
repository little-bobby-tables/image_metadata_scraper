# frozen_string_literal: true
require 'net/http'

require 'image_metadata_scraper/version'
require 'image_metadata_scraper/deviantart'
require 'image_metadata_scraper/tumblr'

module ImageMetadataScraper
  IMAGE_FILE_URL = /\Ahttps?:\/\/.*\.(jpg|jpeg|png|gif|svg)/

  SCRAPERS = {
    /\Ahttps?:\/\/.+deviantart\.com\/.+/ => DeviantArt.method(:post),
    /\Ahttps?:\/\/.+deviantart\.net\/.+d.+/ => DeviantArt.method(:direct_link),
    /\Ahttps?:\/\/.+tumblr\.com\/(post|image)\/.+/ => Tumblr.method(:post),
    IMAGE_FILE_URL => ->(url) { { image_url: url, thumbnail_url: url } }
  }.freeze

  # Returns a hash of scraped image metadata that always contains:
  # +image_url+:     URL to the largest available image file
  # +thumbnail_url+: URL to a small version of the image
  #
  # and includes, if applicable,
  # +artist+:    the name of the artist (blogger)
  # +url+:       canonical URL to the image page (e.g. DeviantArt post)
  #
  # Returns nil if scraping fails.
  def self.scrape(url)
    url = http_url(url) or return
    url = redirect_from(url)

    scraper = SCRAPERS.detect { |regex, _| url =~ regex }&.last or return
    scraper.call(url)
  end

  def self.redirect_from(url)
    response = Net::HTTP.get_response(URI(url.strip))
    case response.code when '301', '302'
      response.header['location']
    else
      url
    end
  end

  def self.http_url(url)
    return if url.blank?

    url = url.strip
    scheme = url.match(/\A.+:\/\//)

    if scheme.nil?
      "http://#{url}"
    elsif scheme.to_s == 'http://' || scheme.to_s == 'https://'
      url
    end
  end
end
