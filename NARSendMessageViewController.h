//
//  NARSendMessageViewController.h
//  narwalrus
//
//  Created by Stephen Portanova on 9/8/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAREmailVCViewController.h"

@interface NARSendMessageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *messageBody;
@property (nonatomic, weak) id<EmailVCParentDelegate> delegate;
@property(strong, atomic) NSURLSession *session;
@property(weak, atomic) NSString *serverUrl;

@end
