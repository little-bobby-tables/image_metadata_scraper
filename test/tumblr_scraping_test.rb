require 'test_helper'

class TumblrScrapingTest < ActiveSupport::TestCase
  test 'post links' do
    scrape 'http://iam-photography.tumblr.com/post/157409807702/crescent-over-the-flame' do |scraped|
      assert_equal({
                     image_url: 'http://68.media.tumblr.com/f68ccec85fba7442ab715691d4d07615/tumblr_oldh8iK0kd1ubet1po1_1280.jpg',
                     artist: 'iam-photography',
                     url: 'http://iam-photography.tumblr.com/post/157409807702/crescent-over-the-flame' }, scraped)
    end
  end
end
