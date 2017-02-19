require 'test_helper'

class DeviantArtScrapingTest < ActiveSupport::TestCase
  test 'fav.me links' do
    scrape 'http://fav.me/daq0vmo' do |scraped|
      assert_equal({
                     image_url: 'http://orig06.deviantart.net/b74a/f/2016/333/b/d/city_by_hangmoon-daq0vmo.jpg',
                     artist: 'Hangmoon',
                     url: 'http://hangmoon.deviantart.com/art/City-648372768' }, scraped)
    end
  end

  test 'posts with downloading disabled' do
    scrape 'http://oo-rein-oo.deviantart.com/art/Heart-Of-The-City-303912988?some-unrelated-parameter=5' do |scraped|
      assert_equal({
                     image_url: 'http://orig02.deviantart.net/b72b/f/2012/144/e/1/e18e380d65641c6e57a6545b33b7a6de-d50xwrg.jpg',
                     artist: 'oO-Rein-Oo',
                     url: 'http://oo-rein-oo.deviantart.com/art/Heart-Of-The-City-303912988' }, scraped)
    end
  end

  test 'mature content posts' do
    scrape 'https://alexiuss.deviantart.com/art/Water-fairy-128204062' do |scraped|
      assert_equal({
                     image_url: 'http://orig02.deviantart.net/9c72/f/2009/184/d/1/water_fairy_by_alexiuss.jpg',
                     artist: 'alexiuss',
                     url: 'http://alexiuss.deviantart.com/art/Water-fairy-128204062' }, scraped)
    end
  end

  test 'direct links to deviantart cdn' do
    scrape 'http://img11.deviantart.net/0d5d/i/2013/206/5/c/part_of_your_no_by_tsaoshin-d6f5s39.png' do |scraped|
      assert_equal({
                     image_url: 'http://orig04.deviantart.net/2183/f/2013/206/9/b/part_of_your_no_by_tsaoshin-d6f5s39.png',
                     artist: 'TsaoShin',
                     url: 'http://tsaoshin.deviantart.com/art/Part-of-Your-No-388260981' }, scraped)
    end
  end
end
