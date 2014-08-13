//
//  NARTopicsTableViewController.h
//  narwalrus
//
//  Created by Stephen Portanova on 8/12/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NARTopicsTableViewController : UITableViewController
@property(strong, atomic) NSURLSession *session;
@property(strong, atomic) NSString *userId;
@end
