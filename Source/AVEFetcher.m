//
//  AVEFetcher.m
//  AvenueFetcher
//
//  Copyright (c) 2015 MediaHound. All rights reserved.
//

#import "AVEFetcher.h"

#import <JSONModel/JSONModel.h>


typedef id(^TransformBlock)(id);


@implementation AVEFetcher

+ (instancetype)sharedFetcher
{
    // Subclasses should implement this.
    return nil;
}

- (PMKPromise*)fetchWithAction:(NSString*)action
                          path:(NSString*)path
                    parameters:(NSDictionary*)parameters
     constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))bodyBlock
                      priority:(AVENetworkPriority*)priority
                  networkToken:(AVENetworkToken*)networkToken
                transformBlock:(TransformBlock)transformBlock
{
    if ([action isEqualToString:@"GET"]) {
        return [[AVENetworkManager sharedManager] GET:path
                                          parameters:parameters
                                            priority:priority
                                        networkToken:networkToken
                                              builder:self.builder].thenInBackground(transformBlock);
    }
    else if ([action isEqualToString:@"PUT"]) {
        return [[AVENetworkManager sharedManager] PUT:path
                                           parameters:parameters
                                            priority:priority
                                         networkToken:networkToken
                                              builder:self.builder].thenInBackground(transformBlock);
    }
    else if ([action isEqualToString:@"POST"]) {
        if (bodyBlock) {
            return [[AVENetworkManager sharedManager] POST:path
                                                parameters:parameters
                                 constructingBodyWithBlock:bodyBlock
                                                  priority:priority
                                              networkToken:networkToken
                                                   builder:self.builder].thenInBackground(transformBlock);
        }
        else {
            return [[AVENetworkManager sharedManager] POST:path
                                                parameters:parameters
                                                  priority:priority
                                              networkToken:networkToken
                                                   builder:self.builder].thenInBackground(transformBlock);
        }
    }
    else {
        @throw [NSException exceptionWithName:@"Invalid fetch action"
                                       reason:@"The fetch action must be `GET`, `POST`, or `PUT`."
                                     userInfo:nil];
    }
}

- (TransformBlock)transformBlockForModel:(Class)modelClass
                                 keyPath:(NSString*)keyPath
{
    return ^id(id responseObject) {
        NSDictionary* dict = (keyPath) ? [responseObject valueForKeyPath:keyPath] : responseObject;
        NSError* error = nil;
        id model = [[modelClass alloc] initWithDictionary:dict error:&error];
        
        if (model) {
            return model;
        }
        else {
            return error;
        }
    };
}

- (PMKPromise*)fetchModel:(Class)modelClass
                     path:(NSString*)path
                  keyPath:(NSString*)keyPath
               parameters:(NSDictionary*)parameters
                 priority:(AVENetworkPriority*)priority
             networkToken:(AVENetworkToken*)networkToken
{
    return [self fetchWithAction:@"GET"
                            path:path
                      parameters:parameters
       constructingBodyWithBlock:nil
                            priority:priority
                    networkToken:networkToken
                  transformBlock:[self transformBlockForModel:modelClass keyPath:keyPath]];
}

- (PMKPromise*)putAndFetchModel:(Class)modelClass
                           path:(NSString*)path
                        keyPath:(NSString*)keyPath
                     parameters:(NSDictionary*)parameters
{
    return [self fetchWithAction:@"PUT"
                            path:path
                      parameters:parameters
       constructingBodyWithBlock:nil
                        priority:[AVENetworkPriority priorityWithLevel:AVENetworkPriorityLevelHigh
                                                          postponeable:NO]
                    networkToken:nil
            transformBlock:[self transformBlockForModel:modelClass keyPath:keyPath]];
}

- (PMKPromise*)postAndFetchModel:(Class)modelClass
                            path:(NSString*)path
                         keyPath:(NSString*)keyPath
                      parameters:(NSDictionary*)parameters
{
    return [self fetchWithAction:@"POST"
                            path:path
                      parameters:parameters
       constructingBodyWithBlock:nil
                        priority:[AVENetworkPriority priorityWithLevel:AVENetworkPriorityLevelHigh
                                                          postponeable:NO]
                    networkToken:nil
                  transformBlock:[self transformBlockForModel:modelClass keyPath:keyPath]];
}

- (PMKPromise*)postAndFetchModel:(Class)modelClass
                            path:(NSString*)path
                         keyPath:(NSString*)keyPath
                      parameters:(NSDictionary*)parameters
       constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))bodyBlock
{
    return [self fetchWithAction:@"POST"
                            path:path
                      parameters:parameters
       constructingBodyWithBlock:bodyBlock
                        priority:[AVENetworkPriority priorityWithLevel:AVENetworkPriorityLevelHigh
                                                          postponeable:NO]
                    networkToken:nil
                  transformBlock:[self transformBlockForModel:modelClass keyPath:keyPath]];
}

@end
