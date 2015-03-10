//
//  DCNetworkReactor.m
//  DCNetworkReactor
//
//  Created by tang dixi on 10/14/14.
//  Copyright (c) 2014 tang dixi. All rights reserved.
//

#import "DCNetworkReactor.h"

#import <AFNetworking/AFNetworking.h>

@interface DCNetworkReactor ()

@property (strong, nonatomic) NSArray *userFileDirectoryPath;

@end

@implementation DCNetworkReactor

#pragma mark - Initialization

- (instancetype)init {
    
    if (self = [super init]) {
        
    }
    return self;
    
}

+ (instancetype)shareDCNetworkReactor {
    
    static DCNetworkReactor *dcNetworkReactor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dcNetworkReactor = [[self alloc]init];
        
    });
    
    return dcNetworkReactor;
}

#pragma mark - Version 2.0

- (NSURL *)constructURL:(NSString *)urlString withParameters:(NSDictionary *)parameters {
    
    for (NSString *key in parameters.allKeys) {
        // Endcode the key
        //
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        // Encode the value
        //
        NSString *encodedValue = [parameters[key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        // Append the value to the key
        //
        NSString *encodedKeyAndValue = [encodedKey stringByAppendingFormat:@"=%@&", encodedValue];
        
        // Append the kayAndValue to the url
        //
        urlString = [urlString stringByAppendingString:encodedKeyAndValue];
    }
    
    // Remove the last charcter, aka "&"
    //
    NSRange lastCharacterRange = NSMakeRange(urlString.length - 1, 1);
    
    urlString = [urlString stringByReplacingCharactersInRange:lastCharacterRange withString:@""];
    
    return [NSURL URLWithString:urlString];
}

- (AFHTTPRequestOperation *)GET:(NSString *)urlString
                              withParameters:(NSDictionary *)parameters
                                     success:(successBlock)success
                                     faliure:(faliureBlock)failure {
    
    // Construct Request
    //
    NSURL *requestURL = [self constructURL:urlString withParameters:parameters];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:requestURL];
    
    // Configure a request operation
    //
    AFHTTPRequestOperation *httpRequestOperation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    httpRequestOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    httpRequestOperation.responseSerializer.acceptableContentTypes = nil;
    
    [httpRequestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
        
    }];
    
    // Auto start the request
    //
    [httpRequestOperation start];
    
    
    return httpRequestOperation;
}

- (AFHTTPRequestOperation *)POST:(NSString *)urlString
                               withParameters:(NSDictionary *)parameters
                                      success:(successBlock)success
                                      failure:(faliureBlock)failure {
    
    AFHTTPRequestOperationManager *httpRequestOperationManager = [AFHTTPRequestOperationManager manager];
//    httpRequestOperationManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    httpRequestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    
    AFHTTPRequestOperation *httpRequestOperation = [httpRequestOperationManager
                                                    POST:urlString
                                                    parameters:parameters
                                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                        
                                                        success(responseObject);
                                                        
                                                    }
                                                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                        
                                                        failure(error);
                                                        
                                                    }];

    
    // Auto start the request
    //
    [httpRequestOperation start];
    
    return httpRequestOperation;
}

- (AFHTTPRequestOperation *)POST:(NSString *)urlString
                       withImage:(UIImage *)image
              withAvatarDominate:(NSString *)avatarDominate
                  withParameters:(NSDictionary *)parameters
                         success:(successBlock)success
                         failure:(faliureBlock)failure {
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    
    AFHTTPRequestSerializer *httpRequestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request = [httpRequestSerializer multipartFormRequestWithMethod:@"POST"
                                                                               URLString:urlString
                                                                              parameters:parameters
                                                               constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                               
                                                                   [formData appendPartWithFileData:imageData
                                                                                               name:avatarDominate
                                                                                           fileName:@"avatar.jpg"
                                                                                           mimeType:@"image/jpeg"];                                                                     
                                                               }
                                                                error:nil];
    
    AFHTTPRequestOperationManager *httpRequestOperationManager = [AFHTTPRequestOperationManager manager];
    httpRequestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    
    AFHTTPRequestOperation *httpRequestOperation = [httpRequestOperationManager
                                                    HTTPRequestOperationWithRequest:request
                                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                        success(responseObject);
                                                    }
                                                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                        failure(error);
                                                    }];
    
    [httpRequestOperation setUploadProgressBlock:^(NSUInteger bytesWritten,
                                                   long long totalBytesWritten,
                                                   long long totalBytesExpectedToWrite) {

        NSLog(@"%lld/%lld", totalBytesWritten, totalBytesExpectedToWrite);
    
    }];
    
    [httpRequestOperation start];
    
    NSLog(@"Request info: header -> %@, body -> %@", httpRequestOperation.request.allHTTPHeaderFields, httpRequestOperation.request.HTTPBodyStream);
    
    return httpRequestOperation;
    
}

@end

