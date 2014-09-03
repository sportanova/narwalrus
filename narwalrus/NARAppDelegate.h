//
//  NARAppDelegate.h
//  narwalrus
//
//  Created by Stephen Portanova on 6/26/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NARAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, atomic) NSString *userId;
@property (strong, atomic) NSString *serverUrl;

@end
