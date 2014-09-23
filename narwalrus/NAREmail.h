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
@property NSString* sender;
@property NSString* recipientsHash;
@property NSMutableArray* recipientsSet;
@property NSString* userId;
@property NSString* textBody;
@property NSString* htmlBody;
@property (assign) NSInteger fullSize;
@property (assign) bool isFullSize;

+ (instancetype)createEmailWithSubject:(NSString *)subject recipientsSet:(NSMutableArray *)recipientsSet recipientsHash:(NSString *)recipientsHash textBody:(NSString *)textBody
  htmlBody:(NSString *)htmlBody sender:(NSString *)sender;

- (instancetype)initWithEmailSubject:(NSString *)name recipientsSet:(NSMutableArray *)recipientsSet recipientsHash:(NSString *)recipientsHash textBody:(NSString *)textBody
  htmlBody:(NSString *)htmlBody sender:(NSString *)sender;
- (NSString *)subject;

@end
