//
//  NARTopic.m
//  narwalrus
//
//  Created by Stephen Portanova on 8/12/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import "NARTopic.h"

@implementation NARTopic
@synthesize subject = _subject;
@synthesize threadId = _threadId;

+ (instancetype)createTopicWithSubject:(NSString *)subject threadId:(NSString *)threadId {
  NARTopic *topic = [[self alloc] initWithTopicSubject:subject threadId:threadId];
  return topic;
}

// Designated initializer for NARTopic
- (instancetype)initWithTopicSubject:(NSString *)subject threadId:(NSString *)threadId {
  self = [super init];
  
  if (self) {
    self.subject = subject;
    self.threadId = threadId;
  }
  
  return self;
}


@end
