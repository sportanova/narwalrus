//
//  NARTopicStore.m
//  narwalrus
//
//  Created by Stephen Portanova on 8/12/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import "NARTopicStore.h"
#import "NARTopic.h"

@interface NARTopicStore()
@property (nonatomic) NSMutableArray *privateTopics;
@end

@implementation NARTopicStore
+ (instancetype)sharedStore {
  static NARTopicStore *sharedStore = nil;
  
  if (!sharedStore) {
    sharedStore = [[self alloc] initPrivate];
  }
  
  return sharedStore;
}

- (void)deleteStore {
  self.privateTopics = [[NSMutableArray alloc] init];
}

- (instancetype)init {
  @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[NARTopicStore sharedStore]" userInfo:nil];
  return nil;
}

- (instancetype)initPrivate {
  self = [super init];
  if(self) {
    _privateTopics = [[NSMutableArray alloc] init];
  }
  return self;
}

- (NARTopic *)createTopicWithSubject:(NSString *)subject threadId:(NSString *)threadId {
  NARTopic *topic = [NARTopic createTopicWithSubject:subject threadId:threadId];
  
  [self.privateTopics addObject:topic];
  
  return topic;
}

- (NSArray *)allTopics {
  return self.privateTopics;
}
@end