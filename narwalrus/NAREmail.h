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
@property NSString* body;

+ (instancetype)createEmailWithSubject:(NSString *)subject recipients:(NSString *)recipients body:(NSString *)body;

// Designated initializer for NAREmail
- (instancetype)initWithEmailSubject:(NSString *)name recipients:(NSString *)recipients body:(NSString *)body;
- (NSString *)subject;

@end
