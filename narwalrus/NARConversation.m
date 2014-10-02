#import "NARConversation.h"

@implementation NARConversation
@synthesize recipients = _recipients;
@synthesize recipientsNames = _recipientsNames;
@synthesize recipientsEmailAddresses = _recipientsEmailAddresses;
@synthesize recipientsHash = _recipientsHash;
@synthesize emailAccountId = _emailAccountId;
@synthesize emailCount = _emailCount;
@synthesize topicCount = _topicCount;

+ (instancetype)createConversationWithRecipientsHash:(NSString *)hash
  recipients:(NSDictionary *)recipients emailAccountId:(NSString *)emailAccountId topicCount:(NSInteger)topicCount emailCount:(NSInteger)emailCount {
  NARConversation *newConversation = [[self alloc] initConversationWithRecipientsHash:hash recipients:recipients emailAccountId:emailAccountId topicCount:topicCount emailCount:emailCount];
  return newConversation;
}

- (instancetype)initConversationWithRecipientsHash:(NSString *)hash recipients:(NSDictionary *)recipients emailAccountId:(NSString *)emailAccountId topicCount:(NSInteger)topicCount emailCount:(NSInteger)emailCount
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
  }
  
  return self;
}

@end
