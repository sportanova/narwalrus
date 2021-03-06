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
#import "NARAppDelegate.h"

@interface NARSendMessageViewController ()
@end

@implementation NARSendMessageViewController
@synthesize serverUrl = _serverUrl;
@synthesize session = _session;

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
  
  self.serverUrl = [(NARAppDelegate *)[[UIApplication sharedApplication] delegate] serverUrl];
  NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
  self.session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];

  [self.messageBody becomeFirstResponder];
}

- (void)sendMessage
{
  NAREmail *lastEmail = [[[NAREmailStore sharedStore] allEmails] lastObject];
  NAREmail *newEmail = [self.delegate addNewEmailWithSubject:lastEmail.subject recipientsSet:lastEmail.recipientsSet threadId:lastEmail.threadId recipientsHash:lastEmail.recipientsHash textBody:self.messageBody.text htmlBody:self.messageBody.text sender:@{@"sportano@gmail.com":@"sportano@gmail.com"} prepend:true messageId:lastEmail.messageId inReplyTo:lastEmail.inReplyTo references:lastEmail.references ts:lastEmail.ts]; // TODO: make this dynaic

  NSMutableString *inReplyTo = nil;
  if(lastEmail.inReplyTo == NULL) {
    inReplyTo = [NSMutableString stringWithString:@"firstReply"];
  }
  else {
    inReplyTo = [NSMutableString stringWithString:lastEmail.inReplyTo];
  }

  NSMutableString *references = nil;
  if(lastEmail.references == NULL) {
    references = [NSMutableString stringWithString:@"firstReply"];
  }
  else {
    references = [NSMutableString stringWithString:lastEmail.references];
  }
  
  NSLog(@"references %@", references);
  
  NSDictionary *emailDict = @{ // TODO - this throws an error if now recipientsHash / recipientsSet???
    @"subject": newEmail.subject,
    @"recipientsHash": newEmail.recipientsHash,
    @"recipients": newEmail.recipientsSet,
    @"textBody": newEmail.textBody,
    @"htmlBody": newEmail.htmlBody,
    @"cc": @"",
    @"bcc": @"",
    @"userId": [(NARAppDelegate *)[[UIApplication sharedApplication] delegate] userId],
    @"sender": @{@"sportano@gmail.com":@"sportano@gmail.com"},
    @"threadId": lastEmail.threadId,
    @"id": @1,
    @"ts": @1,
    @"messageId": lastEmail.messageId,
    @"inReplyTo": inReplyTo,
    @"references": references
  };
  
  NSLog(@"emailDict %@", emailDict);
  
  NSData *emailJson = [NSJSONSerialization dataWithJSONObject:emailDict options:kNilOptions error:nil];
  
  [self postEmail:emailJson emailAccountId:[self.delegate getEmailAccountId] userId:[(NARAppDelegate *)[[UIApplication sharedApplication] delegate] userId]];
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)postEmail:(NSData *)emailJson emailAccountId:(NSString *)emailAccountId userId:(NSString *)userId {
  NSString *requestString = [NSString stringWithFormat: @"%@/emails/send/%@", self.serverUrl, emailAccountId];
  
  NSURL *url = [NSURL URLWithString:requestString];
  NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL: url];
  [req setHTTPMethod: @"POST"];
  [req addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  [req setHTTPBody: emailJson];

  NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
  {
//     NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
     dispatch_async(dispatch_get_main_queue(), ^{
     });
   }];
  [dataTask resume];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
