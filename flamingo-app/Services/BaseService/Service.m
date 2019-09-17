//
//  Service.m
//  Stindy
//
//  Created by Nguyễn Chí Thành on 5/7/19.
//  Copyright © 2019 Nguyễn Chí Thành. All rights reserved.
//
//
//  BaseServices.m
//  ChatApp
//
//  Created by maytuyen on 6/8/17.
//  Copyright © 2017 may985. All rights reserved.
//

#import "Service.h"

@implementation Service

+ (BOOL) isInternetConnected
{
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

+ (instancetype)shared {
    static Service *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void) post:(NSDictionary *)parameters withURL:(NSString*)postUrl success:(void (^)(NSURLSessionDataTask *operation, NSDictionary *responseData))success
      failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    
    if(!self.manager) self.manager = [AFHTTPSessionManager manager];
//    self.manager.requestSerializer =[AFJSONRequestSerializer serializer];
//    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [self.manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [self.manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
//    postUrl = [[NSURL URLWithDataRepresentation:[postUrl dataUsingEncoding:NSUTF8StringEncoding] relativeToURL:nil] relativeString];
//    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [self.manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // Start Get Token
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:K_CURRENT_TOKEN]];
    if ([token isKindOfClass:[NSString class]] && token.length > 0) {
        NSString *bearer = [NSString stringWithFormat:@"Bearer %@", token];
        [self.manager.requestSerializer setValue:bearer forHTTPHeaderField:@"Authorization"];
    }
    // End Get Token
    
    [self.manager POST:postUrl parameters:[mutableDictionary copy] success:^(NSURLSessionDataTask *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            dict[@"data"] = responseObject;
            success(operation, dict);
        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            success(operation, responseObject);
        } else {
            failure(operation, responseObject);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        // Expired Token
        // Request lại token và save, sau đó request lại chính function này
        //            NSString *urlRefreshToken = BASE_URL_TOKEN
        NSDictionary *param = @{
                                @"grant_type" : @"password",
                                @"username" : @"MobileFDLR",
                                @"password" : @"1234!@#$",
                                @"usernameClient": @"admin2",
                                @"passwordClient": @"111111"
                                };
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithDictionary:param];
        [self.manager POST:BASE_URL_TOKEN parameters:[data copy] success:^(NSURLSessionTask *task, id responseObject) {
            if (responseObject == [NSNull null]) {
                failure(operation, error);
            } else {
                if ([responseObject isKindOfClass:[NSDictionary class]] &&
                    [responseObject[@"access_token"] isKindOfClass:[NSString class]]) {
                    NSString *token = responseObject[@"access_token"];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:token] forKey:K_CURRENT_TOKEN];
                    [defaults synchronize];
                    [self post:parameters withURL:postUrl success:success failure:failure];
                } else {
                    failure(operation, error);
                }
            }
            
        } failure:^(NSURLSessionTask *task, NSError *error) {
            NSLog(@"AFHTTPSession Failure : %@", [error localizedDescription]);
        }];
        
    }];
}

- (void) get:(NSDictionary *)parameters withURL:(NSString*)postUrl success:(void (^)(NSURLSessionDataTask *operation, NSDictionary *responseData))success
     failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    
    postUrl = [[NSURL URLWithDataRepresentation:[postUrl dataUsingEncoding:NSUTF8StringEncoding] relativeToURL:nil] relativeString];
    if(!self.manager) self.manager = [AFHTTPSessionManager manager];
    self.manager.requestSerializer =[AFJSONRequestSerializer new];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    // Start Get Token
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:K_CURRENT_TOKEN]];
    if ([token isKindOfClass:[NSString class]] && token.length > 0) {
        NSString *bearer = [NSString stringWithFormat:@"Bearer %@", token];
        [self.manager.requestSerializer setValue:bearer forHTTPHeaderField:@"Authorization"];
    }
    // End Get Token
    
    [self.manager GET:postUrl parameters:[mutableDictionary copy] success:^(NSURLSessionDataTask *operation, id responseObject) {
        success(operation, responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation, error);
    }];
}

- (void) uploadFile:(NSDictionary *)parameters withURL:(NSString*)postUrl success:(void (^)(NSURLSessionDataTask *operation, NSDictionary *responseData))success
            failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    if(!self.manager) self.manager = [AFHTTPSessionManager manager];
    self.manager.requestSerializer =[AFJSONRequestSerializer serializer];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    postUrl = [[NSURL URLWithDataRepresentation:[postUrl dataUsingEncoding:NSUTF8StringEncoding] relativeToURL:nil] relativeString];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [self.manager POST:postUrl parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
        success(operation, responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation, error);
    }];
}


- (void)upload:(NSDictionary *) parameters withURL:(NSString*)postUrl success:(void (^)(NSURLSessionDataTask *operation, NSDictionary *responseData))success
        failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    if(!self.manager) self.manager = [AFHTTPSessionManager manager];
    self.manager.requestSerializer =[AFJSONRequestSerializer serializer];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    postUrl = [[NSURL URLWithDataRepresentation:[postUrl dataUsingEncoding:NSUTF8StringEncoding] relativeToURL:nil] relativeString];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [self.manager POST:postUrl parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
        success(operation, responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation, error);
    }];
}
-(BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection{
    return NO;
}
- (void)putParameters:(NSDictionary *)parameters withURL:(NSString*)postUrl success:(void (^)(NSURLSessionDataTask *, NSDictionary *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    if(!self.manager) self.manager = [AFHTTPSessionManager manager];
    self.manager.requestSerializer =[AFJSONRequestSerializer serializer];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.manager PUT:postUrl parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
        success(operation, responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation, error);
    }];
}
- (void)cancelRequests
{
    [self.manager.operationQueue cancelAllOperations];
}
@end
