# ImageMetadataScraper

```ruby
require 'image_metadata_scraper'
ImageMetadataScraper.scrape 'http://fav.me/shorturl'

=> { :image_url => "http://orig.deviantart.net/image-file-url.jpg",
     :thumbnail_url => "http://pre.deviantart.net/small-image-version-url.jpg",
     :artist => "artist",
     :url => "http://artist.deviantart.com/art/some-piece-123" }
```

[Supported providers](https://github.com/little-bobby-tables/image_metadata_scraper/blob/master/lib/image_metadata_scraper.rb#L11)
