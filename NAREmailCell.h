//
//  NAREmailCell.h
//  narwalrus
//
//  Created by Stephen Portanova on 8/13/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAREmailVCViewController.h"
#import "NAREmail.h"

@protocol EmailCellDelegate;

@interface NAREmailCell : UITableViewCell<UIWebViewDelegate, UIGestureRecognizerDelegate>
- (void)configureCellWithHtmlBody:(NSString *)body textBody:(NSString *)textBody sender:(NSString *)sender;
@property (nonatomic, weak) id<EmailCellDelegate> delegate;
@property (nonatomic, weak) id<EmailCellDelegate> emailDelegate;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *senderLabel;
@property (weak, atomic) NAREmail *email;
@end