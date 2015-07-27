//
//  AVEFetcher.h
//  AvenueFetcher
//
//  Copyright (c) 2015 MediaHound. All rights reserved.
//

#import <PromiseKit/PromiseKit.h>
#import <Avenue/Avenue.h>


/***
 * The AvenueFetcher is intended to be subclassed.
 * Your subclass should configure the `builder` property with
 * an AVEHTTPRequestOperationBuilder that you can configure 
 * appropriately for your networking needs.
 *
 * The AvenueFetcher exposes simple fetch methods that perform
 * GET, PUT, or POST actions on a HTTP resource. The response
 * from the HTTP request is transformed into a model object
 * via JSONModel.
 */
@interface AVEFetcher : NSObject

/***
 * Get the shared AvenueFetcher
 */
+ (instancetype)sharedFetcher;

/***
 * The operation builder that constructs HTTP operations.
 */
@property (strong, nonatomic) AVEHTTPRequestOperationBuilder* builder;

/***
 * Fetches a model from an HTTP resource.
 *
 * @param modelClass The Objective-C class that should be instantiated 
 *   from the network response. This class must inherit from JSONModel.
 * @param path The relative path (from the BaseURL) to the HTTP resource.
 * @param keyPath The respone sub-property keyPath to derive the model
 * @param parameters The network request parameters
 * @param priority The Avenue network priority
 * @param networkToken The Avenue network token
 *
 * @discussion If the model is derived from a sub property in the JSON,
 *   you can pass a `keyPath` to specify where the model should be read from.
 */
- (AnyPromise*)fetchModel:(Class)modelClass
                     path:(NSString*)path
                  keyPath:(NSString*)keyPath
               parameters:(NSDictionary*)parameters
                 priority:(AVENetworkPriority*)priority
             networkToken:(AVENetworkToken*)networkToken;

/***
 * Performs a HTTP PUT operation and treats the
 * response as a model.
 *
 * @param modelClass The Objective-C class that should be instantiated 
 *   from the network response. This class must inherit from JSONModel.
 * @param path The relative path (from the BaseURL) to the HTTP resource.
 * @param keyPath The respone sub-property keyPath to derive the model
 * @param parameters The network request parameters
 * @param priority The Avenue network priority
 * @param networkToken The Avenue network token
 *
 * @discussion If the model is derived from a sub property in the JSON,
 *   you can pass a `keyPath` to specify where the model should be read from.
 */
- (AnyPromise*)putAndFetchModel:(Class)modelClass
                           path:(NSString*)path
                        keyPath:(NSString*)keyPath
                     parameters:(NSDictionary*)parameters;

/***
 * Performs a HTTP POST operation and treats the
 * response as a model.
 *
 * @param modelClass The Objective-C class that should be instantiated 
 *   from the network response. This class must inherit from JSONModel.
 * @param path The relative path (from the BaseURL) to the HTTP resource.
 * @param keyPath The respone sub-property keyPath to derive the model
 * @param parameters The network request parameters
 * @param priority The Avenue network priority
 * @param networkToken The Avenue network token
 *
 * @discussion If the model is derived from a sub property in the JSON,
 *   you can pass a `keyPath` to specify where the model should be read from.
 */
- (AnyPromise*)postAndFetchModel:(Class)modelClass
                            path:(NSString*)path
                         keyPath:(NSString*)keyPath
                      parameters:(NSDictionary*)parameters;

/***
 * Performs a HTTP POST with Body Block operation and treats the
 * response as a model.
 *
 * @param modelClass The Objective-C class that should be instantiated 
 *   from the network response. This class must inherit from JSONModel.
 * @param path The relative path (from the BaseURL) to the HTTP resource.
 * @param keyPath The respone sub-property keyPath to derive the model
 * @param parameters The network request parameters
 * @param priority The Avenue network priority
 * @param networkToken The Avenue network token
 *
 * @discussion If the model is derived from a sub property in the JSON,
 *   you can pass a `keyPath` to specify where the model should be read from.
 */
- (AnyPromise*)postAndFetchModel:(Class)modelClass
                            path:(NSString*)path
                         keyPath:(NSString*)keyPath
                      parameters:(NSDictionary*)parameters
       constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))bodyBlock;

@end
