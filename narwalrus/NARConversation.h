#import <Foundation/Foundation.h>

@interface NARConversation : NSObject
@property NSString* recipients;
@property NSString* recipientsHash;
@property NSString* emailAccountId;

+ (instancetype)createConversationWithRecipientsHash:(NSString *)hash
  recipients:(NSString *)recipients emailAccountId:(NSString *)emailAccountId;

// Designated initializer for NARConversation
- (instancetype)initConversationWithRecipientsHash:(NSString *)hash recipients:(NSString *)recipients emailAccountId:(NSString *)emailAccountId;

@end
