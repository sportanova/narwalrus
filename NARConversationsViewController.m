//
//  NARConversationsViewController.m
//  narwalrus
//
//  Created by Stephen Portanova on 7/4/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import "NARConversationsViewController.h"
#import "NARConversationStore.h"
#import "NARConversation.h"
#import "NAREmailsViewController.h"
#import "NARAppDelegate.h"

@implementation NARConversationsViewController
@synthesize userId = _userId;

- (instancetype)init {
  self = [super initWithStyle:UITableViewStylePlain];
  
  NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
  self.session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
  
  self.userId = [(NARAppDelegate *)[[UIApplication sharedApplication] delegate] userId];
  
  [self fetchConversations];

  return self;
}

// on tap, show emails
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSArray *conversations = [[NARConversationStore sharedStore] allConversations];
  NARConversation *conversation = conversations[indexPath.row];
  
  NAREmailsViewController *emailsVC = [[NAREmailsViewController alloc] initWithConversation:conversation userId:self.userId];
  emailsVC.conversation = conversation;
  [self.navigationController pushViewController:emailsVC animated:YES];
}

- (NARConversation *)addNewConversationWithSubject:(NSString *)subject recipients:(NSString *)recipients {
  NARConversation *newConversation = [[NARConversationStore sharedStore] createConversationWithSubject:subject
    recipients:recipients];
  
  NSInteger lastRow = [[[NARConversationStore sharedStore] allConversations] indexOfObject:newConversation];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
  
  [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];

  return newConversation;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[[NARConversationStore sharedStore] allConversations] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
  
  NSArray *conversations = [[NARConversationStore sharedStore] allConversations];
  NARConversation *conversation = conversations[indexPath.row];
  
  cell.textLabel.text = [conversation subject];
  
  return cell;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}


- (void)fetchConversations
{
  NSString *requestString = [NSString stringWithFormat:@"http://localhost:8080/conversations/%@", self.userId];
  NSURL *url = [NSURL URLWithString:requestString];
  NSURLRequest *req = [NSURLRequest requestWithURL:url];
  
  NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req
   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
     NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//     NSLog(@"getting here data: %@", jsonArray);
//     NSDictionary *secondItem = [jsonArray objectAtIndex:1];
//     NSLog(@"secondItem: %@", secondItem);
//     NSString *subject = secondItem[@"subject"];
//     NSLog(@"subject: %@", subject);
     
     
     dispatch_async(dispatch_get_main_queue(), ^{
       for(NSDictionary *conversationDict in jsonArray) {
//         NSLog(@"conversation:%@", conversationDict);
         NSString *subject = [conversationDict objectForKey:@"subject"];
         NSString *recipients = [conversationDict objectForKey:@"recipientsHash"];
//         NSLog(@"subject:%@", subject);
//         NSLog(@"recipients:%@", recipients);
         [self addNewConversationWithSubject:subject recipients:recipients];
       }
       
     });
   }];
  [dataTask resume];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
  return [self init];
}

@end
