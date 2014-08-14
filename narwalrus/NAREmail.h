//
//  NAREmail.h
//  narwalrus
//
//  Created by Stephen Portanova on 7/10/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NAREmail : NSObject
@property NSString* subject;
@property NSString* recipients;
@property NSString* userId;
@property NSString* textBody;
@property NSString* htmlBody;

+ (instancetype)createEmailWithSubject:(NSString *)subject recipients:(NSString *)recipients textBody:(NSString *)textBody
  htmlBody:(NSString *)htmlBody;

// Designated initializer for NAREmail
- (instancetype)initWithEmailSubject:(NSString *)name recipients:(NSString *)recipients textBody:(NSString *)textBody
  htmlBody:(NSString *)htmlBody;
- (NSString *)subject;

@end
