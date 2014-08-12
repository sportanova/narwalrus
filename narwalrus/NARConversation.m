#import "NARConversation.h"

@implementation NARConversation
@synthesize subject = _subject;
@synthesize recipients = _recipients;
@synthesize recipientsHash = _recipientsHash;

+ (instancetype)createConversationWithRecipientsHash:(NSString *)hash
  recipients:(NSString *)recipients {
  NARConversation *newConversation = [[self alloc] initConversationWithRecipientsHash:hash recipients:recipients];
  return newConversation;
}

- (instancetype)initConversationWithRecipientsHash:(NSString *)hash recipients:(NSString *)recipients {
  self = [super init];
  
  if (self) {
    self.recipients = recipients;
    self.recipientsHash = hash;
  }
  
  return self;
}

@end
