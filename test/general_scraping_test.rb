require 'test_helper'

class ImageLinkScrapingTest < ActiveSupport::TestCase
  test 'returns the url' do
    assert_scraped 'https://example.com/some/path/image.png',
                   {
                     image_url: 'https://example.com/some/path/image.png',
                     thumbnail_url: 'https://example.com/some/path/image.png'
                   }
  end

  test 'returns nil when scraping fails' do
    assert_scraped 'https://example.com/random/path/without/image', nil
  end
end
