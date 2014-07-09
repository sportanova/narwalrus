#import "NARConversation.h"

@implementation NARConversation

+ (instancetype)createConversationWithSubject:(NSString *)subject recipients:(NSString *)recipients {
  NARConversation *newConversation = [[self alloc] initWithConversationSubject:subject recipients:recipients];
  return newConversation;
}

- (instancetype)initWithConversationSubject:(NSString *)subject recipients:(NSString *)recipients {
  self = [super init];
  
  if (self) {
    _subject = subject;
    _recipients = recipients;
  }
  
  return self;
}

- (NSString *)subject {
  return _subject;
}

@end
