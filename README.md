# ImageMetadataScraper

[![Build Status](https://travis-ci.org/little-bobby-tables/image_metadata_scraper.svg?branch=master)](https://travis-ci.org/little-bobby-tables/image_metadata_scraper)
[![Test Coverage](https://codeclimate.com/github/little-bobby-tables/image_metadata_scraper/badges/coverage.svg)](https://codeclimate.com/github/little-bobby-tables/image_metadata_scraper/coverage)
[![Gem Version](https://badge.fury.io/rb/image_metadata_scraper.svg)](https://badge.fury.io/rb/image_metadata_scraper)

```ruby
require 'image_metadata_scraper'
ImageMetadataScraper.scrape 'http://fav.me/shorturl'

=> { :image_url => "http://orig.deviantart.net/image-file-url.jpg",
     :thumbnail_url => "http://pre.deviantart.net/small-image-version-url.jpg",
     :artist => "artist",
     :url => "http://artist.deviantart.com/art/some-piece-123" }
```

[Supported providers](https://github.com/little-bobby-tables/image_metadata_scraper/blob/master/lib/image_metadata_scraper.rb#L11)
