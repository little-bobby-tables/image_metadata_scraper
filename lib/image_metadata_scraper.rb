# frozen_string_literal: true
require 'net/http'

require 'image_metadata_scraper/version'
require 'image_metadata_scraper/deviantart'

module ImageMetadataScraper
  IMAGE_FILE_URL = /\Ahttps?:\/\/.*(.jpg|.jpeg|.png|.gif|.svg)/

  SCRAPERS = {
    /\Ahttps?:\/\/.*deviantart.com\/.+/ => DeviantArt.method(:post),
    /\Ahttps?:\/\/.*deviantart.net\/.+d.+/ => DeviantArt.method(:direct_link),
    IMAGE_FILE_URL => ->(url) { { image_url: url } }
  }.freeze

  # Returns a hash of scraped image metadata that always contains:
  # +image_url+: URL to the largest available image file
  #
  # and includes, if applicable,
  # +artist+:    the name of the artist (blogger)
  # +url+:       canonical URL to the image page (e.g. DeviantArt post)
  def self.scrape(url)
    url = url.strip
    url = redirect_from(url)

    SCRAPERS.detect { |regex, _| url =~ regex }.last.call(url)
  end

  def self.redirect_from(url)
    response = Net::HTTP.get_response(URI(url.strip))
    case response.code when '301', '302'
      response.header['location']
    else
      url
    end
  end
end