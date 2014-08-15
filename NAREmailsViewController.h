//
//  NAREmailsViewController.h
//  narwalrus
//
//  Created by Stephen Portanova on 7/10/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NAREmailCell.h"

@class NARTopic;
@class NAREmailCell;
@protocol EmailCellDelegate;

@interface NAREmailsViewController : UITableViewController<EmailCellDelegate>
@property(strong, atomic) NSURLSession *session;
@property(strong,atomic) NARTopic *topic;
@property(strong,atomic) NSString *userId;

- (instancetype)initWithTopic:(NARTopic *)topic userId:(NSString *)userId;
@end