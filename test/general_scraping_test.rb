require 'test_helper'
require 'webmock/minitest'

class ImageLinkScrapingTest < ActiveSupport::TestCase
  test 'returns direct urls' do
    assert_scraped 'https://example.com/some/path/image.png',
                   {
                     image_url: 'https://example.com/some/path/image.png',
                     thumbnail_url: 'https://example.com/some/path/image.png'
                   }
  end

  test 'assumes HTTP when no protocol is specified' do
    assert_scraped 'example.com/some/path/image.png',
                   {
                     image_url: 'http://example.com/some/path/image.png',
                     thumbnail_url: 'http://example.com/some/path/image.png'
                   }
  end

  test 'returns nil when scraping fails' do
    assert_scraped 'https://example.com/random/path/without/image', nil
  end

  test 'only follows HTTP and HTTPs links' do
    %w(gopher sftp tftp dict).each do |protocol|
      stub_request :any, "#{protocol}://mockhost.net/file"
      ImageMetadataScraper.scrape "#{protocol}://mockhost.net/file"
      assert_not_requested :any, "#{protocol}://mockhost.net/file"
    end

    %w(http https).each do |protocol|
      stub_request :any, "#{protocol}://mockhost.net/file"
      ImageMetadataScraper.scrape "#{protocol}://mockhost.net/file"
      assert_requested :any, "#{protocol}://mockhost.net/file"
    end
  end
end
