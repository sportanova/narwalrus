//
//  NARConversationsViewController.m
//  narwalrus
//
//  Created by Stephen Portanova on 6/26/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import "NARConversationsViewController.h"

@interface NARConversationsViewController () <NSURLSessionDataDelegate>
  @property (nonatomic) NSURLSession *session;
  @property (nonatomic, copy) NSArray *courses;
@end

@implementation NARConversationsViewController

- (void)fetchStuff
{
  NSString *requestString = @"http://localhost:8080/conversations/";
  NSURL *url = [NSURL URLWithString:requestString];
  NSURLRequest *req = [NSURLRequest requestWithURL:url];
  
  NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req
   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
     NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
     NSLog(@"getting here data: %@", jsonArray);
     NSDictionary *secondItem = [jsonArray objectAtIndex:1];
     NSLog(@"secondItem: %@", secondItem);
     NSString *subject = secondItem[@"subject"];
     NSLog(@"subject: %@", subject);

    dispatch_async(dispatch_get_main_queue(), ^{
      
    });
  }];
  [dataTask resume];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
  self.session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
  
  [self fetchStuff];

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
