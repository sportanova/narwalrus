//
//  NAREmailVCViewController.h
//  narwalrus
//
//  Created by Stephen Portanova on 9/7/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAREmailsViewController.h"

@class NARTopic;
@class NAREmailCell;

@interface NAREmailVCViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, EmailCellDelegate>
@property(strong, atomic) NSURLSession *session;
@property(strong,atomic) NARTopic *topic;
@property(strong,atomic) NSString *userId;
@property (assign, atomic) double lastResizeTime;
@property(weak, atomic) NSString *serverUrl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;

- (instancetype)initWithTopic:(NARTopic *)topic userId:(NSString *)userId;
@end
