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
@synthesize recipients = _recipients;
@synthesize textBody = _textBody;
@synthesize htmlBody = _htmlBody;
@synthesize isFullSize = _isFullSize;

+ (instancetype)createEmailWithSubject:(NSString *)subject recipients:(NSString *)recipients textBody:(NSString *)textBody
  htmlBody:(NSString *)htmlBody {
  NAREmail *newEmail = [[self alloc] initWithEmailSubject:subject recipients:recipients textBody:textBody htmlBody:htmlBody];
  return newEmail;
}

- (instancetype)initWithEmailSubject:(NSString *)subject recipients:(NSString *)recipients textBody:(NSString *)textBody
  htmlBody:(NSString *)htmlBody {
  self = [super init];
  
  if (self) {
    self.subject = subject;
    self.recipients = recipients;
    self.textBody = textBody;
    self.htmlBody = htmlBody;
    self.isFullSize = false;
  }
  
  return self;
}

- (void)flipFullSize
{
  self.isFullSize = !self.isFullSize;
}


@end
