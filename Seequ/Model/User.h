
#import "RLMObject.h"
#import <Realm/Realm.h>
#import "Contact.h"


@interface User : RLMObject

@property NSString *_id; //To be renamed to "id"
@property NSString *name;
@property NSString *email;
@property RLMArray<Contact> *contacts;

@end
