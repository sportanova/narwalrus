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
#import "NARConversation.h"
#import "NARAppDelegate.h"
#import "NARTopicCell.h"
#import "NAREmailVCViewController.h"

@implementation NARTopicsTableViewController
@synthesize userId = _userId;
@synthesize conversation = _conversation;

- (instancetype)initWithConversation:(NARConversation *)conversation userId:(NSString *)userId{
  self = [super initWithStyle:UITableViewStylePlain];
  
  // TODO: reference cycle?
  self.conversation = conversation;
  self.userId = userId;
  self.serverUrl = [(NARAppDelegate *)[[UIApplication sharedApplication] delegate] serverUrl];
  
  NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
  self.session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
  
  [self fetchTopicsWithUserId:self.userId recipientsHash:conversation.recipientsHash];
  
  return self;
}

- (void)viewDidDisappear:(BOOL)animated {
  if ([self.navigationController.viewControllers indexOfObject:self]==0) {
    [[NARTopicStore sharedStore] deleteStore];
  }
  
  [super viewDidDisappear:animated];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSArray *topics = [[NARTopicStore sharedStore] allTopics];
  NARTopic *topic = topics[indexPath.row];

  NAREmailVCViewController *emailVC = [[NAREmailVCViewController alloc] initWithTopic:topic userId:self.userId emailAccountId:self.conversation.emailAccountId];
  [self.navigationController pushViewController:emailVC animated:YES];
}

- (NARTopic *)addNewTopicWithSubject:(NSString *)subject threadId:(NSString *)threadId {
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
  NARTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NARTopicCell" forIndexPath:indexPath];
  
  NSArray *topics = [[NARTopicStore sharedStore] allTopics];
  NARTopic *topic = topics[indexPath.row];
  
  cell.subjectLabel.text = [topic subject];
  cell.subjectLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:12.0f];
  
  return cell;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor colorWithRed:108.0f/255.0f green:122.0f/255.0f blue:137.0f/255.0f alpha:1.0f];

  UINib *nib = [UINib nibWithNibName:@"NARTopicCell" bundle:nil];
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  
  [self.tableView registerNib:nib forCellReuseIdentifier:@"NARTopicCell"];
}

- (void)fetchTopicsWithUserId:(NSString *)userId recipientsHash:(NSString *)hash {
  NSString *requestString = [NSString stringWithFormat:@"%@/topics/%@/%@", self.serverUrl, userId, hash];
  NSURL *url = [NSURL URLWithString:requestString];
  NSURLRequest *req = [NSURLRequest requestWithURL:url];
  
  NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req
  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
     
    dispatch_async(dispatch_get_main_queue(), ^{
      for(NSDictionary *topicDict in jsonArray) {
        NSString *subject = [topicDict objectForKey:@"subject"];
        NSString *threadId = [topicDict objectForKey:@"threadId"];
        
        [self addNewTopicWithSubject:subject threadId:threadId];
      }
    });
  }];
  [dataTask resume];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
  return [self init];
}

@end
