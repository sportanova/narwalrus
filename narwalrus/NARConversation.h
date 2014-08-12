#import <Foundation/Foundation.h>

@interface NARConversation : NSObject
@property NSString* subject;
@property NSString* recipients;
@property NSString* recipientsHash;

+ (instancetype)createConversationWithSubject:(NSString *)subject recipientsHash:(NSString *)hash
  recipients:(NSString *)recipients;

// Designated initializer for NARConversation
- (instancetype)initWithConversationSubject:(NSString *)name recipientsHash:(NSString *)hash recipients:(NSString *)recipients;

@end
