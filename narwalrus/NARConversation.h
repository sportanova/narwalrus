#import <Foundation/Foundation.h>

@interface NARConversation : NSObject
@property NSDictionary* recipients;
@property NSString* recipientsHash;
@property NSString* emailAccountId;
@property NSInteger emailCount;
@property NSInteger topicCount;
@property NSString *ts;
@property NSString *recipientsNames;
@property NSArray *recipientsEmailAddresses;

+ (instancetype)createConversationWithRecipientsHash:(NSString *)hash recipients:(NSDictionary *)recipients emailAccountId:(NSString *)emailAccountId topicCount:(NSInteger)topicCount emailCount:(NSInteger)emailCount ts:(NSString *)ts;

// Designated initializer for NARConversation
- (instancetype)initConversationWithRecipientsHash:(NSString *)hash recipients:(NSDictionary *)recipients emailAccountId:(NSString *)emailAccountId topicCount:(NSInteger)topicCount emailCount:(NSInteger)emailCount ts:(NSString *)ts;

@end
