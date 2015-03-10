
#import "RingAPIManager.h"


@implementation RingAPIManager

- (instancetype)init {
    
    NSString *abstractClassAssertMessage =
    [NSString stringWithFormat:@"%@ is an abstract class. Please use one of its concrete subclasses", NSStringFromSelector(_cmd)];
    
    NSAssert(![self isMemberOfClass:[RingAPIManager class]], abstractClassAssertMessage);
    
    return [super init];
}

@end
