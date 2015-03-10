
@import Foundation;
#import "SeequLib.h"

/*
 This is an abstract class. Please use one of its concrete subclasses 
(e.g. RingAccountManager, RingContactsAPIManager) 
*/


typedef NS_ENUM(NSUInteger, RingAPIManagerError) {
    RingAPIManagerErrorBadArgument = 1
};


@interface RingAPIManager : NSObject

@end
