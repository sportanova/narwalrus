//
//  NARConversationStore.m
//  narwalrus
//
//  Created by Stephen Portanova on 7/7/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import "NARConversationStore.h"
#import "NARConversation.h"

@interface NARConversationStore()
  @property (nonatomic) NSMutableArray *privateConversations;
@end

@implementation NARConversationStore
+ (instancetype)sharedStore {
  static NARConversationStore *sharedStore = nil;
  
  if (!sharedStore) {
    sharedStore = [[self alloc] initPrivate];
  }
  
  return sharedStore;
}

- (instancetype)init {
  @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[NARConversationStore sharedStore]" userInfo:nil];
  return nil;
}

- (instancetype)initPrivate {
  self = [super init];
  if(self) {
    _privateConversations = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)deleteStore {
  self.privateConversations = [[NSMutableArray alloc] init];
}

- (NARConversation *)createConversationWithRecipientsHash:(NSString *)hash
  recipients:(NSString *)recipients emailAccountId:(NSString *)emailAccountId topicCount:(NSInteger)topicCount emailCount:(NSInteger)emailCount ts:(NSString *)ts
{
  NARConversation *conversation = [NARConversation createConversationWithRecipientsHash:hash recipients:recipients emailAccountId:emailAccountId topicCount:topicCount emailCount:emailCount ts:ts];
  
  [self.privateConversations addObject:conversation];
  
  return conversation;
}

- (NSArray *)allConversations {
  return self.privateConversations;
}
@end
