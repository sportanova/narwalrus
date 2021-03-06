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
- (NAREmail *)createEmailWithSubject:(NSString *)subject recipientsSet:(NSMutableArray *)recipientsSet threadId:(NSString *)threadId recipientsHash:(NSString *)recipientsHash textBody:(NSString *)textBody htmlBody:(NSString *)htmlBody sender:(NSDictionary *)sender prepend:(bool)prepend messageId:(NSString *)messageId inReplyTo:(NSString *)inReplyTo references:(NSString *)references ts:(NSString *)ts;
@end
