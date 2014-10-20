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
@synthesize emailCount = _emailCount;
@synthesize ts = _ts;

+ (instancetype)createTopicWithSubject:(NSString *)subject threadId:(NSString *)threadId emailCount:(NSInteger)emailCount ts:(NSString *)ts
{
  NARTopic *topic = [[self alloc] initWithTopicSubject:subject threadId:threadId emailCount:emailCount ts:ts];
  return topic;
}

// Designated initializer for NARTopic
- (instancetype)initWithTopicSubject:(NSString *)subject threadId:(NSString *)threadId emailCount:(NSInteger)emailCount ts:(NSString *)ts
{
  self = [super init];
  
  if (self) {
    self.subject = subject;
    self.threadId = threadId;
    self.emailCount = emailCount;
    self.ts = ts;
  }
  
  return self;
}


@end
