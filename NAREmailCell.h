//
//  NAREmailCell.h
//  narwalrus
//
//  Created by Stephen Portanova on 8/13/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAREmailsViewController.h"
#import "NAREmail.h"

@protocol EmailCellDelegate;

@interface NAREmailCell : UITableViewCell<UIWebViewDelegate, UIGestureRecognizerDelegate>
- (void)configureCellWithBody:(NSString *)body;
@property (nonatomic, weak) id<EmailCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, atomic) NAREmail *email;
@property (assign, atomic) bool useFullSize;
@end

@protocol EmailCellDelegate <NSObject>

- (void)refreshTable;

@end