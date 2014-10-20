#import "NARConversation.h"

@implementation NARConversation
@synthesize recipients = _recipients;
@synthesize recipientsNames = _recipientsNames;
@synthesize recipientsEmailAddresses = _recipientsEmailAddresses;
@synthesize recipientsHash = _recipientsHash;
@synthesize emailAccountId = _emailAccountId;
@synthesize emailCount = _emailCount;
@synthesize topicCount = _topicCount;
@synthesize ts = _ts;

+ (instancetype)createConversationWithRecipientsHash:(NSString *)hash
  recipients:(NSDictionary *)recipients emailAccountId:(NSString *)emailAccountId topicCount:(NSInteger)topicCount emailCount:(NSInteger)emailCount ts:(NSString *)ts {
  NARConversation *newConversation = [[self alloc] initConversationWithRecipientsHash:hash recipients:recipients emailAccountId:emailAccountId topicCount:topicCount emailCount:emailCount ts:ts];
  return newConversation;
}

- (instancetype)initConversationWithRecipientsHash:(NSString *)hash recipients:(NSDictionary *)recipients emailAccountId:(NSString *)emailAccountId topicCount:(NSInteger)topicCount emailCount:(NSInteger)emailCount ts:(NSString *)ts
{
  self = [super init];
  
  NSMutableArray *recipientsNames = [[NSMutableArray alloc] init];
  NSMutableArray *recipientsEmailAddresses = [[NSMutableArray alloc] init];

  for (id key in recipients) {
    [recipientsEmailAddresses addObject:recipients[key]];
    NSString *name = [[key componentsSeparatedByString:@" "] objectAtIndex:0];
    [recipientsNames addObject:(name)];
  }
  
  if (self) {
    self.recipients = recipients;
    self.recipientsNames = [recipientsNames componentsJoinedByString:@", "];
    self.recipientsEmailAddresses = recipientsEmailAddresses;
    self.recipientsHash = hash;
    self.emailAccountId = emailAccountId;
    self.topicCount = topicCount;
    self.emailCount = emailCount;
    self.ts = ts;
  }
  
  return self;
}

@end
