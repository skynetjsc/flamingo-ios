//
//  Service.m
//  Stindy
//
//  Created by Nguyễn Chí Thành on 5/7/19.
//  Copyright © 2019 Nguyễn Chí Thành. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define BASE_URL @"http://mobile.flamingogroup.com.vn:6789"
#define BASE_URL_TOKEN @"http://mobile.flamingogroup.com.vn:6789/Token"
#define K_CURRENT_TOKEN @"CURRENT_TOKEN"

@interface Service : NSObject <NSURLConnectionDataDelegate>

+ (instancetype)shared;
+ (BOOL) isInternetConnected;
@property (nonatomic, strong) AFHTTPSessionManager *manager;

- (void) post:(NSDictionary *)parameters withURL:(NSString*)postUrl success:(void (^)(NSURLSessionDataTask *operation, NSDictionary *responseData))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
- (void) get:(NSDictionary *)parameters withURL:(NSString*)postUrl success:(void (^)(NSURLSessionDataTask *operation, NSDictionary *responseData))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
@end
