//
//  NARTopicsTableViewController.h
//  narwalrus
//
//  Created by Stephen Portanova on 8/12/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NARConversation;

@interface NARTopicsTableViewController : UITableViewController
@property(strong, atomic) NSURLSession *session;
@property(strong, atomic) NSString *userId;
@property(weak,atomic) NARConversation *conversation;
@property(weak, atomic) NSString *serverUrl;

- (instancetype)initWithConversation:(NARConversation *)conversation userId:(NSString *)userId;

@end
