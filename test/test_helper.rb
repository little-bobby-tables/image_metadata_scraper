$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.start do
  add_filter 'test'
end

require 'webmock'
WebMock.disable_net_connect!

require 'vcr'
VCR.configure do |c|
  c.default_cassette_options = { record: :once, serialize_with: :compressed }

  c.hook_into :webmock
  c.cassette_library_dir = File.expand_path('./cassettes', File.dirname(__FILE__))
end

require 'minitest/autorun'
require 'minitest/reporters'
require 'active_support/all'

require 'image_metadata_scraper'

Minitest.backtrace_filter = Minitest::BacktraceFilter.new
Minitest::Reporters.use!

def scrape(url)
  VCR.use_cassette Digest::MD5.hexdigest(url) do
    yield ImageMetadataScraper.scrape(url)
  end
end

def assert_scraped(url, expected)
  scrape(url) do |scraped|
    if expected.nil?
      assert_nil scraped
    else
      assert_equal expected, scraped
    end
  end
end
