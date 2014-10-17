//
//  NAREmail.h
//  narwalrus
//
//  Created by Stephen Portanova on 7/10/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EmailCellDelegate;

@interface NAREmail : NSObject<EmailCellDelegate>
@property NSString* subject;
@property NSDictionary* sender;
@property NSString* recipientsHash;
@property NSMutableArray* recipientsSet;
@property NSString* userId;
@property NSString* threadId;
@property NSString* textBody;
@property NSString* htmlBody;
@property NSString* messageId;
@property NSString* inReplyTo;
@property NSString* references;
@property (assign) NSInteger fullSize;
@property (assign) bool isFullSize;

+ (instancetype)createEmailWithSubject:(NSString *)subject recipientsSet:(NSMutableArray *)recipientsSet threadId:(NSString *)threadId recipientsHash:(NSString *)recipientsHash textBody:(NSString *)textBody htmlBody:(NSString *)htmlBody sender:(NSDictionary *)sender messageId:(NSString *)messageId inReplyTo:(NSString *)inReplyTo references:(NSString *)references;

- (instancetype)initWithEmailSubject:(NSString *)name recipientsSet:(NSMutableArray *)recipientsSet threadId:(NSString *)threadId recipientsHash:(NSString *)recipientsHash textBody:(NSString *)textBody
  htmlBody:(NSString *)htmlBody sender:(NSDictionary *)sender messageId:(NSString *)messageId inReplyTo:(NSString *)inReplyTo references:(NSString *)references;

- (NSString *)subject;

@end
