//
//  Seequ_Lib.m
//  Seequ.Lib
//
//  Created by Jose Correa on 3/6/15.
//  Copyright (c) 2015 Seequ. All rights reserved.
//

#import "SeequLib.h"

#import "AFNetworking.h"


@implementation SeequLib

+(void)postToPath:(NSString*)path body:(NSDictionary*)body success:(Success)success failure:(Failure)failure
{
    // Create manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"%@/%@", BASE_URL, path];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults objectForKey:@"SeequUserToken"];
    NSString *header = [NSString stringWithFormat:@"Bearer %@", token];
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:body error:NULL];
    [request setValue:header forHTTPHeaderField:@"Authorization"];
    // NSLog(@"Request: %@", [[NSString alloc] initWithData:request.HTTPBody encoding:kCFStringEncodingUTF8]);
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                             success(responseObject);
                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             failure(operation.responseObject, error);
                                                                         }];
    [manager.operationQueue addOperation:operation];
}

+(void)getFromPath:(NSString*)path body:(NSDictionary*)body success:(Success)success failure:(Failure)failure
{
    // Create manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"%@/%@", BASE_URL, path];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults objectForKey:@"SeequUserToken"];
    NSString *header = [NSString stringWithFormat:@"Bearer %@", token];
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:body error:NULL];
    [request setValue:header forHTTPHeaderField:@"Authorization"];
    // NSLog(@"Request: %@", [[NSString alloc] initWithData:request.HTTPBody encoding:kCFStringEncodingUTF8]);
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                             success(responseObject);
                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             failure(operation.responseObject, error);
                                                                         }];
    [manager.operationQueue addOperation:operation];
}


+(void)putToPath:(NSString*)path body:(NSDictionary*)body success:(Success)success failure:(Failure)failure
{
    // Create manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"%@/%@", BASE_URL, path];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults objectForKey:@"SeequUserToken"];
    NSString *header = [NSString stringWithFormat:@"Bearer %@", token];
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"PUT" URLString:url parameters:body error:NULL];
    [request setValue:header forHTTPHeaderField:@"Authorization"];
    // NSLog(@"Request: %@", [[NSString alloc] initWithData:request.HTTPBody encoding:kCFStringEncodingUTF8]);
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                             success(responseObject);
                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             failure(operation.responseObject, error);
                                                                         }];
    [manager.operationQueue addOperation:operation];
}

+(void)group:(NSString*)groupId addContacts:(NSArray*)contacts success:(Success)success failure:(Failure)failure
{
    // Create manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // JSON Body
    NSDictionary* bodyObject = @{@"contacts": contacts};
    
    NSString *url = [NSString stringWithFormat:@"%@/api/groups/%@/contacts", BASE_URL, groupId];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults objectForKey:@"SeequUserToken"];
    NSString *header = [NSString stringWithFormat:@"Bearer %@", token];
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:bodyObject error:NULL];
    
    // Add Headers
    [request setValue:token forHTTPHeaderField:@"Authorization"];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                             success(responseObject);
                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             failure(operation.responseObject, error);
                                                                         }];
    [manager.operationQueue addOperation:operation];
}



@end
