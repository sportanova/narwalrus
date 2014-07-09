#import "NARConversation.h"

@implementation NARConversation
@synthesize subject = _subject;
@synthesize recipients = _recipients;

+ (instancetype)createConversationWithSubject:(NSString *)subject recipients:(NSString *)recipients {
  NARConversation *newConversation = [[self alloc] initWithConversationSubject:subject recipients:recipients];
  return newConversation;
}

- (instancetype)initWithConversationSubject:(NSString *)subject recipients:(NSString *)recipients {
  self = [super init];
  
  if (self) {
    self.subject = subject;
    self.recipients = recipients;
  }
  
  return self;
}

@end
