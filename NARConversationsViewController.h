//
//  NARConversationsViewController.h
//  narwalrus
//
//  Created by Stephen Portanova on 7/4/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NARConversationsViewController : UITableViewController
  @property(weak, atomic) NSURLSession *session;
@end
