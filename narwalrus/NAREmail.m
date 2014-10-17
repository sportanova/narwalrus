//
//  NAREmail.m
//  narwalrus
//
//  Created by Stephen Portanova on 7/10/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import "NAREmail.h"

@implementation NAREmail
@synthesize subject = _subject;
@synthesize recipientsSet = _recipientsSet;
@synthesize recipientsHash = _recipientsHash;
@synthesize textBody = _textBody;
@synthesize htmlBody = _htmlBody;
@synthesize isFullSize = _isFullSize;
@synthesize sender = _sender;
@synthesize threadId = _threadId;
@synthesize messageId = _messageId;
@synthesize inReplyTo = _inReplyTo;
@synthesize references = _references;

+ (instancetype)createEmailWithSubject:(NSString *)subject recipientsSet:(NSMutableArray *)recipientsSet threadId:(NSString *)threadId recipientsHash:(NSString *)recipientsHash textBody:(NSString *)textBody
  htmlBody:(NSString *)htmlBody sender:(NSDictionary *)sender messageId:(NSString *)messageId inReplyTo:(NSString *)inReplyTo references:(NSString *)references
{
  NAREmail *newEmail = [[self alloc] initWithEmailSubject:subject recipientsSet:(NSMutableArray *)recipientsSet threadId:(NSString *)threadId recipientsHash:recipientsHash textBody:textBody htmlBody:htmlBody
  sender:sender messageId:messageId inReplyTo:inReplyTo references:references];
  return newEmail;
}

- (instancetype)initWithEmailSubject:(NSString *)subject recipientsSet:(NSMutableArray *)recipientsSet threadId:(NSString *)threadId recipientsHash:(NSString *)recipientsHash textBody:(NSString *)textBody
  htmlBody:(NSString *)htmlBody sender:(NSDictionary *)sender messageId:(NSString *)messageId inReplyTo:(NSString *)inReplyTo references:(NSString *)references
{
  self = [super init];
  
  if (self) {
    self.subject = subject;
    self.recipientsSet = recipientsSet;
    self.recipientsHash = recipientsHash;
    self.textBody = textBody;
    self.htmlBody = htmlBody;
    self.sender = sender;
    self.isFullSize = false;
    self.threadId = threadId;
    self.messageId = messageId;
    self.inReplyTo = inReplyTo;
    self.references = references;
  }
  
  return self;
}

- (void)flipFullSize
{
  self.isFullSize = !self.isFullSize;
}


@end
