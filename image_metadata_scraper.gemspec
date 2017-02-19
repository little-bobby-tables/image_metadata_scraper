$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'image_metadata_scraper/version'
Gem::Specification.new do |spec|
  spec.name          = 'image_metadata_scraper'
  spec.version       = ImageMetadataScraper::VERSION
  spec.authors       = ['little-bobby-tables']
  spec.email         = ['little-bobby-tables@users.noreply.github.com']

  spec.summary       = 'Simple image metadata scraper.'
  spec.homepage      = 'https://github.com/little-bobby-tables/image_metadata_scraper'
  spec.license       = 'CC0-1.0'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'nokogiri'
  spec.add_runtime_dependency 'activesupport'

  spec.add_development_dependency 'openssl'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'minitest-reporters'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'codeclimate-test-reporter'
end
