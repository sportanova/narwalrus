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
@synthesize body = _body;

+ (instancetype)createEmailWithSubject:(NSString *)subject recipients:(NSString *)recipients body:(NSString *)body {
  NAREmail *newEmail = [[self alloc] initWithEmailSubject:subject recipients:recipients body:body];
  return newEmail;
}

- (instancetype)initWithEmailSubject:(NSString *)subject recipients:(NSString *)recipients body:(NSString *)body {
  self = [super init];
  
  if (self) {
    self.subject = subject;
    self.recipients = recipients;
    self.body = body;
  }
  
  return self;
}

@end
