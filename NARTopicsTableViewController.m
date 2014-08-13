//
//  NARTopicsTableViewController.m
//  narwalrus
//
//  Created by Stephen Portanova on 8/12/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import "NARTopicsTableViewController.h"
#import "NARTopicStore.h"
#import "NARTopic.h"
#import "NAREmailsViewController.h"
#import "NARAppDelegate.h"
#import "NARConversationCell.h"

@implementation NARTopicsTableViewController
@synthesize userId = _userId;

- (instancetype)init {
  self = [super initWithStyle:UITableViewStylePlain];
  
  NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
  self.session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
  
  // TODO: reference cycle?
  self.userId = [(NARAppDelegate *)[[UIApplication sharedApplication] delegate] userId];
  
  [self fetchConversations];
  
  return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSArray *topics = [[NARTopicStore sharedStore] allTopics];
  NARConversation *conversation = topics[indexPath.row];
  
  NAREmailsViewController *emailsVC = [[NAREmailsViewController alloc] initWithConversation:conversation userId:self.userId];
  emailsVC.conversation = conversation;
  [self.navigationController pushViewController:emailsVC animated:YES];
}

- (NARTopic *)addNewTopicWithSubject:(NSString *)subject threadId:(int64_t)threadId {
  NARTopic *newTopic = [[NARTopicStore sharedStore] createTopicWithSubject:subject threadId:threadId];
  
  NSInteger lastRow = [[[NARTopicStore sharedStore] allTopics] indexOfObject:newTopic];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
  
  [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
  
  return newTopic;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[[NARTopicStore sharedStore] allTopics] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NARConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NARTopicCell" forIndexPath:indexPath];
  
  NSArray *topics = [[NARTopicStore sharedStore] allTopics];
  NARTopic *topic = topics[indexPath.row];
  
  cell.recipientsLabel.text = [topic subject];
  cell.recipientsLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:12.0f];
  
  return cell;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableConversationViewCell"];
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
    NSLog(@"getting here data: %@", jsonArray);
     //     NSDictionary *secondItem = [jsonArray objectAtIndex:1];
     //     NSLog(@"secondItem: %@", secondItem);
     //     NSString *subject = secondItem[@"subject"];
     //     NSLog(@"subject: %@", subject);
     
     
    dispatch_async(dispatch_get_main_queue(), ^{
      for(NSDictionary *topicDict in jsonArray) {
         //         NSLog(@"conversation:%@", conversationDict);
        NSString *subject = [topicDict objectForKey:@"subject"];
        NSString *threadId = [topicDict objectForKey:@"threadId"]; // need to make int64
        
        [self addNewTopicWithSubject:subject threadId:44];
      }
    });
  }];
  [dataTask resume];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
  return [self init];
}

@end
