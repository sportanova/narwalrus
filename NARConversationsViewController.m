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
#import "NARTopicsTableViewController.h"
#import "NARAppDelegate.h"
#import "NARConversationCell.h"

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
  
  NARTopicsTableViewController *topicsVC = [[NARTopicsTableViewController alloc] initWithConversation:conversation userId:self.userId];
  topicsVC.conversation = conversation;
  [self.navigationController pushViewController:topicsVC animated:YES];
}

- (NARConversation *)addNewConversationWithSubject:(NSString *)subject recipientsHash:(NSString *)recipientsHash recipients:(NSString *)recipients {
  NARConversation *newConversation = [[NARConversationStore sharedStore] createConversationWithRecipientsHash:recipientsHash recipients:recipients];
  
  NSInteger lastRow = [[[NARConversationStore sharedStore] allConversations] indexOfObject:newConversation];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
  
  [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];

  return newConversation;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[[NARConversationStore sharedStore] allConversations] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NARConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NARConversationCell" forIndexPath:indexPath];
  
  NSArray *conversations = [[NARConversationStore sharedStore] allConversations];
  NARConversation *conversation = conversations[indexPath.row];
  
  cell.recipientsLabel.text = [conversation recipients];
  cell.recipientsLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:12.0f];
  
  return cell;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor colorWithRed:108.0f/255.0f green:122.0f/255.0f blue:137.0f/255.0f alpha:1.0f];

  UINib *nib = [UINib nibWithNibName:@"NARConversationCell" bundle:nil];
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  
  [self.tableView registerNib:nib forCellReuseIdentifier:@"NARConversationCell"];
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
         NSString *recipientsHash = [conversationDict objectForKey:@"recipientsHash"];

         NSArray *recipientsJSON = [conversationDict objectForKey:@"recipients"];
         NSString * recipients = [[recipientsJSON valueForKey:@"description"] componentsJoinedByString:@", "];

         [self addNewConversationWithSubject:subject recipientsHash:recipientsHash recipients:recipients];
       }
     });
   }];
  [dataTask resume];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
  return [self init];
}

@end
