
#import "RingNetworkingManager.h"


@interface RingContactNetworkingManager : RingNetworkingManager

+ (instancetype)sharedInstance;

-(void)group:(NSString*)groupId addContacts:(NSArray*)contacts success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure;
-(void)getGroupListWithSuccess:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure;
-(void)getGroupDetailsWithGroupID:(NSString *)groupID Success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure;
-(void)addContacts:(NSArray*)contacts toGroup:(NSString*)groupId success:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure;
-(void)createGroupWithSuccess:(RingNetworkingLibSuccessBlock)success failure:(RingNetworkingLibFailureBlock)failure;


@end
