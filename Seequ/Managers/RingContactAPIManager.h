
#import "RingAPIManager.h"


@interface RingContactAPIManager : RingAPIManager

+ (instancetype)sharedInstance;

-(void)group:(NSString*)groupId addContacts:(NSArray*)contacts success:(Success)success failure:(Failure)failure;
-(void)getGroupListWithSuccess:(Success)success failure:(Failure)failure;
-(void)getGroupDetailsWithGroupID:(NSString *)groupID Success:(Success)success failure:(Failure)failure;
-(void)addContacts:(NSArray*)contacts toGroup:(NSString*)groupId success:(Success)success failure:(Failure)failure;
-(void)createGroupWithSuccess:(Success)success failure:(Failure)failure;


@end
