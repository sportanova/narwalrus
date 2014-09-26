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

+ (instancetype)createTopicWithSubject:(NSString *)subject threadId:(NSString *)threadId emailCount:(NSInteger)emailCount
{
  NARTopic *topic = [[self alloc] initWithTopicSubject:subject threadId:threadId emailCount:emailCount];
  return topic;
}

// Designated initializer for NARTopic
- (instancetype)initWithTopicSubject:(NSString *)subject threadId:(NSString *)threadId emailCount:(NSInteger)emailCount
{
  self = [super init];
  
  if (self) {
    self.subject = subject;
    self.threadId = threadId;
    self.emailCount = emailCount;
  }
  
  return self;
}


@end
