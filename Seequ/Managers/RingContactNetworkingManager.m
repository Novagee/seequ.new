
#import "RingContactNetworkingManager.h"


@implementation RingContactNetworkingManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static RingContactNetworkingManager *contactManager;
    dispatch_once(&onceToken, ^{
        contactManager = [[RingContactNetworkingManager alloc] init];
    });
    return  contactManager;
}

-(void)group:(NSString*)groupId addContacts:(NSArray*)contacts success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure
{
    
}

-(void)getGroupListWithSuccess:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure
{
    [RingNetworkingLib getFromPath:RING_NETWORKING_LIB_GROUP_PATH body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
}

-(void)getGroupDetailsWithGroupID:(NSString *)groupID Success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure
{
    [RingNetworkingLib getFromPath:[NSString stringWithFormat:@"%@/%@",RING_NETWORKING_LIB_GROUP_PATH, groupID] body:@{} success:^(id successResponse) {
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        failure(failureResponse, error);
    }];
}

-(void)addContacts:(NSArray*)contacts toGroup:(NSString*)groupId success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure
{
    NSDictionary* bodyObject = @{@"contacts": contacts};

    [RingNetworkingLib postToPath:[NSString stringWithFormat:@"api/groups/%@/contacts",groupId] body:bodyObject success:^(id successResponse) {
        NSLog(@"%@",successResponse);
    } failure:^(id failureResponse, NSError *error) {
        
    }];
}

-(void)createGroupWithSuccess:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure
{
    [RingNetworkingLib postToPath:RING_NETWORKING_LIB_GROUP_PATH body:@{} success:^(id successResponse) {
        NSLog(@"%@",successResponse);
        success(successResponse);
    } failure:^(id failureResponse, NSError *error) {
        
    }];
}

@end
