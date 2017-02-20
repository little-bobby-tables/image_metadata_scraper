require 'test_helper'

class TumblrScrapingTest < ActiveSupport::TestCase
  test 'post links' do
    assert_scraped 'http://iam-photography.tumblr.com/post/157409807702/crescent-over-the-flame',
                   {
                     image_url: 'http://68.media.tumblr.com/f68ccec85fba7442ab715691d4d07615/tumblr_oldh8iK0kd1ubet1po1_1280.jpg',
                     thumbnail_url: 'http://68.media.tumblr.com/f68ccec85fba7442ab715691d4d07615/tumblr_oldh8iK0kd1ubet1po1_500.jpg',
                     artist: 'iam-photography',
                     url: 'http://iam-photography.tumblr.com/post/157409807702/crescent-over-the-flame'
                   }
  end

  test 'post links without a slug' do
    assert_scraped 'http://regnumsaturni.tumblr.com/post/155685354066',
                   {
                     image_url: 'http://68.media.tumblr.com/f4258a9dd1a3ed4e7122a8f7a5563095/tumblr_ojl0jzV49W1s0jbtpo1_1280.jpg',
                     thumbnail_url: 'http://68.media.tumblr.com/f4258a9dd1a3ed4e7122a8f7a5563095/tumblr_ojl0jzV49W1s0jbtpo1_500.jpg',
                     artist: 'regnumsaturni',
                     url: 'http://regnumsaturni.tumblr.com/post/155685354066'
                   }
  end
end
