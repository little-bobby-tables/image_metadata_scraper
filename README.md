# ImageMetadataScraper

```ruby
require 'image_metadata_scraper'
ImageMetadataScraper.scrape 'http://artist.deviantart.com/art/some-piece-123'

=> { :image_url => "http://orig.deviantart.net/image-file-url.jpg", 
     :artist => "artist", 
     :url => "http://artist.deviantart.com/art/some-piece-123" }
```
