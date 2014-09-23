//
//  NARSendMessageViewController.m
//  narwalrus
//
//  Created by Stephen Portanova on 9/8/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import "NARSendMessageViewController.h"
#import "NAREmailStore.h"
#import "NAREmail.h"

@interface NARSendMessageViewController ()

@end

@implementation NARSendMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleBordered target:self action:@selector(sendMessage)];

  self.navigationItem.rightBarButtonItem = sendButton;

  [self.messageBody becomeFirstResponder];
}

- (void)sendMessage
{
  int count1 = [[[NAREmailStore sharedStore] allEmails] count];
  NSLog(@"1: %d", count1);

  NAREmail *lastEmail = [[[NAREmailStore sharedStore] allEmails] lastObject];
  [[NAREmailStore sharedStore] createEmailWithSubject:lastEmail.subject recipientsSet:lastEmail.recipientsSet recipientsHash:lastEmail.recipientsHash textBody:@"wat" htmlBody:@"HEY OOOH" sender:@"sportano@gmail.com"]; // TODO: MAKE THIS DYNAMIC!!!
  
  int count2 = [[[NAREmailStore sharedStore] allEmails] count];
  NSLog(@"2: %d", count2);
  
  NSLog(@"SENDING TO: %@", lastEmail.recipientsSet);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
