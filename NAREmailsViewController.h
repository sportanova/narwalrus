//
//  NAREmailsViewController.h
//  narwalrus
//
//  Created by Stephen Portanova on 7/10/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NARConversation;

// don't want this to be a table
@interface NAREmailsViewController : UITableViewController
@property(strong, atomic) NSURLSession *session;
@property(strong,atomic) NARConversation *conversation;
@property(strong,atomic) NSString *userId;

- (instancetype)initWithConversation:(NARConversation *)conversation userId:(NSString *)userId;
@end