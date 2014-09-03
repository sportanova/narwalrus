//
//  NARAppDelegate.m
//  narwalrus
//
//  Created by Stephen Portanova on 6/26/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import "NARAppDelegate.h"
#import "NARConversationsViewController.h"

@implementation NARAppDelegate
@synthesize userId = _userId;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//  NSBundle *appBundle = [NSBundle mainBundle];

  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  self.userId = @"bbe1131d-3be5-4997-a1ee-295f6f2c9dbf";
  
  self.serverUrl = @"http://narmal.com";
//  self.serverUrl = @"http://localhost:8080"; // local
  
    // Override point for customization after application launch.
  NARConversationsViewController *conversationsVC = [[NARConversationsViewController alloc] init];
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:conversationsVC];
  
//  for (NSString* family in [UIFont familyNames])
//  {
//    NSLog(@"%@", family);
//    
//    for (NSString* name in [UIFont fontNamesForFamilyName: family])
//    {
//      NSLog(@"  %@", name);
//    }
//  }
  
  self.window.rootViewController = navController;

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
