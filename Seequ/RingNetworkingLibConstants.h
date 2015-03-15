

#import <Foundation/Foundation.h>


extern NSString *const RING_NETWORKING_LIB_BASE_URL;
extern NSString *const RING_NETWORKING_LIB_SIGNIN_PATH;
extern NSString *const RING_NETWORKING_LIB_SIGNUP_PATH;
extern NSString *const RING_NETWORKING_LIB_SIGNOUT_PATH;
extern NSString *const RING_NETWORKING_LIB_RESET_PASSWORD_PATH;
extern NSString *const RING_NETWORKING_LIB_GROUP_PATH;

typedef void (^RingNetworkingLibSuccessBlock) (id successResponse);
typedef void (^RingNetworkingLibFailureBlock) (id failureResponse, NSError *error);
