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
  NAREmail *lastEmail = [[[NAREmailStore sharedStore] allEmails] lastObject];
  NSLog(@"array %@", [[NAREmailStore sharedStore] allEmails]);
  [[NAREmailStore sharedStore] createEmailWithSubject:lastEmail.subject recipientsHash:lastEmail.recipientsHash textBody:lastEmail.textBody htmlBody:@"HEY OOOH" sender:@"sportano@gmail.com"]; // TODO: MAKE THIS DYNAMIC!!!
  
  NSLog(@"SENDING");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
