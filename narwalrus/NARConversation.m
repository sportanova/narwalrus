#import "NARConversation.h"

@implementation NARConversation
@synthesize recipients = _recipients;
@synthesize recipientsHash = _recipientsHash;
@synthesize emailAccountId = _emailAccountId;

+ (instancetype)createConversationWithRecipientsHash:(NSString *)hash
  recipients:(NSString *)recipients emailAccountId:(NSString *)emailAccountId {
  NARConversation *newConversation = [[self alloc] initConversationWithRecipientsHash:hash recipients:recipients emailAccountId:emailAccountId];
  return newConversation;
}

- (instancetype)initConversationWithRecipientsHash:(NSString *)hash recipients:(NSString *)recipients emailAccountId:(NSString *)emailAccountId
{
  self = [super init];
  
  if (self) {
    self.recipients = recipients;
    self.recipientsHash = hash;
    self.emailAccountId = emailAccountId;
  }
  
  return self;
}

@end
