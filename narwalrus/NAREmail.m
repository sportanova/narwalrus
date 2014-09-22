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
@synthesize recipientsHash = _recipientsHash;
@synthesize textBody = _textBody;
@synthesize htmlBody = _htmlBody;
@synthesize isFullSize = _isFullSize;
@synthesize sender = _sender;

+ (instancetype)createEmailWithSubject:(NSString *)subject recipientsHash:(NSString *)recipientsHash textBody:(NSString *)textBody
  htmlBody:(NSString *)htmlBody sender:(NSString *)sender
{
  NAREmail *newEmail = [[self alloc] initWithEmailSubject:subject recipientsHash:recipientsHash textBody:textBody htmlBody:htmlBody
  sender:sender];
  return newEmail;
}

- (instancetype)initWithEmailSubject:(NSString *)subject recipientsHash:(NSString *)recipientsHash textBody:(NSString *)textBody
  htmlBody:(NSString *)htmlBody sender:(NSString *)sender
{
  self = [super init];
  
  if (self) {
    self.subject = subject;
    self.recipientsHash = recipientsHash;
    self.textBody = textBody;
    self.htmlBody = htmlBody;
    self.sender = sender;
    self.isFullSize = false;
  }
  
  return self;
}

- (void)flipFullSize
{
  self.isFullSize = !self.isFullSize;
}


@end
