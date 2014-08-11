//
//  NAREmailsViewController.m
//  narwalrus
//
//  Created by Stephen Portanova on 7/10/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import "NAREmailsViewController.h"
#import "NARConversationsViewController.h"
#import "NAREmailStore.h"
#import "NAREmail.h"
#import "NARConversation.h"

@implementation NAREmailsViewController
@synthesize conversation = _conversation;
@synthesize userId = _userId;

- (instancetype)initWithConversation:(NARConversation *)conversation userId:(NSString *)userId{
  self = [super initWithStyle:UITableViewStylePlain];
  
  self.conversation = conversation;
  self.userId = userId;
  
  NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
  self.session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];

  [self fetchEmailsWithUserId:self.userId subject:conversation.subject recipientsHash:conversation.recipients];
  
  return self;
}

- (void)viewDidDisappear:(BOOL)animated {
  NSLog(@"!!!!!!!!!!!! DISAPPEARING");
  [[NAREmailStore sharedStore] deleteStore];
}

- (NAREmail *)addNewEmailWithSubject:(NSString *)subject recipients:(NSString *)recipients body:(NSString *)body {
  NAREmail *newEmail = [[NAREmailStore sharedStore] createEmailWithSubject:subject recipients:recipients body:body];
  
  NSInteger lastRow = [[[NAREmailStore sharedStore] allEmails] indexOfObject:newEmail];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
  
  [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
  
  return newEmail;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[[NAREmailStore sharedStore] allEmails] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableEmailViewCell" forIndexPath:indexPath];
  
  NSArray *emails = [[NAREmailStore sharedStore] allEmails];
  NAREmail *email = emails[indexPath.row];
  
  cell.textLabel.text = email.body;
  cell.textLabel.font = [UIFont fontWithName:@"Bariol" size:14.0f];
  
  return cell;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableEmailViewCell"];
}


- (void)fetchEmailsWithUserId:(NSString *)userId subject:(NSString *)subject recipientsHash:(NSString *)recipients {

  // use hash instead of encoding?
  NSString *encodedString = [subject stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
  NSString *requestString = [NSString stringWithFormat: @"http://localhost:8080/emails?userId=%@&subject=%@&recipientsHash=%@",
    userId, encodedString, recipients];
  NSLog(@"REQUEST STRING: %@", requestString);
  NSLog(@"subject %@", subject);

  NSURL *url = [NSURL URLWithString:requestString];
  NSURLRequest *req = [NSURLRequest requestWithURL:url];
  
  NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req
   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
     NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//     NSLog(@"############ json: %@", jsonArray);
     dispatch_async(dispatch_get_main_queue(), ^{
       for(NSDictionary *EmailDict in jsonArray) {
         //         NSLog(@"Email:%@", EmailDict);
         NSString *subject = [EmailDict objectForKey:@"subject"];
         NSString *recipients = [EmailDict objectForKey:@"recipients"];
         NSString *body = [EmailDict objectForKey:@"body"];
//         NSLog(@"subject:%@", subject);
//         NSLog(@"recipients:%@", recipients);
//         NSLog(@"body:%@", body);
         [self addNewEmailWithSubject:subject recipients:recipients body:body];
       }
     });
   }];
  [dataTask resume];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
  return [self init];
}

@end
