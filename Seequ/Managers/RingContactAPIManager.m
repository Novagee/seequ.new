
#import "RingContactAPIManager.h"


@implementation RingContactAPIManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static RingContactAPIManager *contactManager;
    dispatch_once(&onceToken, ^{
        contactManager = [[RingContactAPIManager alloc] init];
    });
    return  contactManager;
}

-(void)group:(NSString*)groupId addContacts:(NSArray*)contacts success:(Success)success failure:(Failure)failure
{
    
}

-(void)getGroupListWithSuccess:(Success)success failure:(Failure)failure
{
    [SeequLib getFromPath:GROUP_PATH body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
}

-(void)getGroupDetailsWithGroupID:(NSString *)groupID Success:(Success)success failure:(Failure)failure
{
    [SeequLib getFromPath:[NSString stringWithFormat:@"%@/%@",GROUP_PATH, groupID] body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
}

-(void)addContacts:(NSArray*)contacts toGroup:(NSString*)groupId success:(Success)success failure:(Failure)failure
{
    NSDictionary* bodyObject = @{@"contacts": contacts};

    [SeequLib postToPath:[NSString stringWithFormat:@"api/groups/%@/contacts",groupId] body:bodyObject success:^(id successResponse) {
        NSLog(@"%@",successResponse);
    } failure:^(id failureResponse, NSError *error) {
        
    }];
}

-(void)createGroupWithSuccess:(Success)success failure:(Failure)failure
{
    [SeequLib postToPath:GROUP_PATH body:@{} success:^(id successResponse) {
        NSLog(@"%@",successResponse);
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        
    }];
}

@end
