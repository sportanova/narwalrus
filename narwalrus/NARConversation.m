#import "NARConversation.h"

@implementation NARConversation
@synthesize recipients = _recipients;
@synthesize recipientsHash = _recipientsHash;
@synthesize emailAccountId = _emailAccountId;
@synthesize emailCount = _emailCount;
@synthesize topicCount = _topicCount;

+ (instancetype)createConversationWithRecipientsHash:(NSString *)hash
  recipients:(NSString *)recipients emailAccountId:(NSString *)emailAccountId topicCount:(NSInteger)topicCount emailCount:(NSInteger)emailCount {
  NARConversation *newConversation = [[self alloc] initConversationWithRecipientsHash:hash recipients:recipients emailAccountId:emailAccountId topicCount:topicCount emailCount:emailCount];
  return newConversation;
}

- (instancetype)initConversationWithRecipientsHash:(NSString *)hash recipients:(NSString *)recipients emailAccountId:(NSString *)emailAccountId topicCount:(NSInteger)topicCount emailCount:(NSInteger)emailCount
{
  self = [super init];
  
  if (self) {
    self.recipients = recipients;
    self.recipientsHash = hash;
    self.emailAccountId = emailAccountId;
    self.topicCount = topicCount;
    self.emailCount = emailCount;
  }
  
  return self;
}

@end
