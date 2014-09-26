#import <Foundation/Foundation.h>

@interface NARConversation : NSObject
@property NSString* recipients;
@property NSString* recipientsHash;
@property NSString* emailAccountId;
@property NSInteger emailCount;
@property NSInteger topicCount;

+ (instancetype)createConversationWithRecipientsHash:(NSString *)hash
  recipients:(NSString *)recipients emailAccountId:(NSString *)emailAccountId topicCount:(NSInteger)topicCount emailCount:(NSInteger)emailCount;

// Designated initializer for NARConversation
- (instancetype)initConversationWithRecipientsHash:(NSString *)hash recipients:(NSString *)recipients emailAccountId:(NSString *)emailAccountId topicCount:(NSInteger)topicCount emailCount:(NSInteger)emailCount;

@end
