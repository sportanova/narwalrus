#import "NARConversation.h"

@implementation NARConversation
@synthesize subject = _subject;
@synthesize recipients = _recipients;
@synthesize recipientsHash = _recipientsHash;

+ (instancetype)createConversationWithSubject:(NSString *)subject recipientsHash:(NSString *)hash
  recipients:(NSString *)recipients {
  NARConversation *newConversation = [[self alloc] initWithConversationSubject:subject recipientsHash:hash recipients:recipients];
  return newConversation;
}

- (instancetype)initWithConversationSubject:(NSString *)subject recipientsHash:(NSString *)hash recipients:(NSString *)recipients {
  self = [super init];
  
  if (self) {
    self.subject = subject;
    self.recipients = recipients;
    self.recipientsHash = hash;
  }
  
  return self;
}

@end
