Pod::Spec.new do |s|
  s.name             = "AvenueFetcher"
  s.version          = "0.3.0"
  s.summary          = "JSON Fetching for Avenue"
  s.homepage         = "https://github.com/MediaHound/AvenueFetcher"
  s.license          = 'Apache'
  s.author           = { "Dustin Bachrach" => "dustin@mediahound.com" }
  s.source           = { :git => "https://github.com/MediaHound/AvenueFetcher.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Source/*.{h,m}'

  s.dependency 'Avenue', '~> 0.3'
  s.dependency 'JSONModel', '~> 1.1'
  s.dependency 'PromiseKit/CorePromise', '~> 2.0'
end
