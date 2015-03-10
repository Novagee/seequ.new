
#import "RLMObject.h"
#import <Realm/Realm.h>


@interface Contact : RLMObject

@property NSString *_id; //To be renamed to "id"
@property NSString *name;
@property NSString *email;
@property (readonly) NSArray *users; //We should never have more than one object in this array

@end

RLM_ARRAY_TYPE(Contact)
