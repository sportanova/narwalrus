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
@property NSString* recipients;
@property NSString* userId;
@property NSString* textBody;
@property NSString* htmlBody;
@property (assign) NSInteger fullSize;
@property (assign) bool isFullSize;

+ (instancetype)createEmailWithSubject:(NSString *)subject recipients:(NSString *)recipients textBody:(NSString *)textBody
  htmlBody:(NSString *)htmlBody;

- (instancetype)initWithEmailSubject:(NSString *)name recipients:(NSString *)recipients textBody:(NSString *)textBody
  htmlBody:(NSString *)htmlBody;
- (NSString *)subject;

//- (void)flipFullSize;

@end
