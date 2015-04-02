# AvenueFetcher

AvenueFetcher is a simple component that builds on [Avenue](https://github.com/mediahound/avenue). It provides an abstract class, `AVEFetcher` that makes fetching [JSONModel](https://github.com/icanzilb/JSONModel) model objects from network requests easy. 

<!--
[![Version](https://img.shields.io/cocoapods/v/Avenue.svg?style=flat)](http://cocoadocs.org/docsets/Avenue)
[![License](https://img.shields.io/cocoapods/l/Avenue.svg?style=flat)](http://cocoadocs.org/docsets/Avenue)
[![Platform](https://img.shields.io/cocoapods/p/Avenue.svg?style=flat)](http://cocoadocs.org/docsets/Avenue)
-->

## Installation

AvenueFetcher is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "AvenueFetcher", :git => "https://github.com/MediaHound/AvenueFetcher.git"

## Setup

Simply Subclass AVEFetcher, and impelment `+sharedFetcher`:

```objc
@interface MYFetcher : AVEFetcher

@end
```
```objc
```
@implementation MYFetcher

+ (instancetype)sharedFetcher
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
```

You also need to configure the fetcher's `builder`. A builder is an instance of `AVEHTTPRequestOperationBuilder`. It describes details about all of the fetcher's requests, like baseURL, request/response serialization, security policy, etc.

Typically, you will want to configure the `builder` in your `-init` method:

```objc
- (instancetype)init
{
    if (self = [super init]) {
        NSURL* baseURL = [NSURL URLWithString:@"https://myurl.com"];
        AVEHTTPRequestOperationBuilder* builder = [[AVEHTTPRequestOperationBuilder alloc] initWithBaseURL:baseURL];

        self.builder = builder;
    }
    return self;
}
```

## Using the Fetcher

Making requests with the fetcher is simple:

```objc
[[MYFetcher sharedFetcher] fetchModel:MYModel.class
                                 path:@"model/1"
                              keyPath:nil
                           parameters:nil
                             priority:[AVENetworkPriority priorityWithLevel:AVENetworkPriorityLevelHigh]
                         networkToken:nil].then(^(MYModel* model) {
    // Use the `model`.
});
```

## Author

MediaHound

## License

Avenue is available under the Apache License 2.0. See the LICENSE file for more info.
