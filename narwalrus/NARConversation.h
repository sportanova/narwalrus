#import <Foundation/Foundation.h>

@interface NARConversation : NSObject
@property NSString* subject;
@property NSString* recipients;
@property NSString* recipientsHash;

+ (instancetype)createConversationWithRecipientsHash:(NSString *)hash
  recipients:(NSString *)recipients;

// Designated initializer for NARConversation
- (instancetype)initConversationWithRecipientsHash:(NSString *)hash recipients:(NSString *)recipients;

@end
