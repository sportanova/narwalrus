//
//  NAREmailStore.h
//  narwalrus
//
//  Created by Stephen Portanova on 7/10/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NAREmail;

@interface NAREmailStore : NSObject
@property (nonatomic, readonly) NSArray *allEmails;
- (void)deleteStore;
+ (instancetype)sharedStore;
- (NAREmail *)createEmailWithSubject:(NSString *)subject recipients:(NSString *)recipients textBody:(NSString *)textBody
  htmlBody:(NSString *)htmlBody;
@end
