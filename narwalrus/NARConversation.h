#import <Foundation/Foundation.h>

@interface NARConversation : NSObject
@property NSString* subject;
@property NSString* recipients;

+ (instancetype)createConversationWithSubject:(NSString *)subject recipients:(NSString *)recipients;

// Designated initializer for NARConversation
- (instancetype)initWithConversationSubject:(NSString *)name recipients:(NSString *)recipients;

@end
