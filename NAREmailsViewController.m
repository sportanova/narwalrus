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
#import "NARTopic.h"
#import "NARConversation.h"
#import "NAREmailCell.h"

@interface NAREmailsViewController()
@property (nonatomic, strong) NAREmailCell *prototypeCell;
@end

@implementation NAREmailsViewController
@synthesize topic = _topic;
@synthesize userId = _userId;

- (instancetype)initWithTopic:(NARTopic *)topic userId:(NSString *)userId {
//  [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
  self = [super initWithStyle:UITableViewStylePlain];
  
  self.topic = topic;
  self.userId = userId;
  
  NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
  self.session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];

  [self fetchEmailsWithUserId:self.userId threadId:self.topic.threadId];
  
  return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NAREmail *email = [self getEmailAtIndexPath:(NSIndexPath *)indexPath];
  
  NSInteger height = 201;
  if(email.isFullSize == true) {
    height = email.fullSize;
  }
  
  return height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return UITableViewAutomaticDimension;
}

- (void)viewDidDisappear:(BOOL)animated {
  [[NAREmailStore sharedStore] deleteStore];
}

- (NAREmail *)addNewEmailWithSubject:(NSString *)subject recipients:(NSString *)recipients textBody:(NSString *)textBody
  htmlBody:(NSString *)htmlBody
{
  NAREmail *newEmail = [[NAREmailStore sharedStore] createEmailWithSubject:subject recipients:recipients textBody:textBody htmlBody:htmlBody];
  
  NSInteger lastRow = [[[NAREmailStore sharedStore] allEmails] indexOfObject:newEmail];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
  
  [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
  
  return newEmail;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[[NAREmailStore sharedStore] allEmails] count];
}

- (NAREmail *)getEmailAtIndexPath:(NSIndexPath *)indexPath
{
  NSArray *emails = [[NAREmailStore sharedStore] allEmails];
  NAREmail *email = emails[indexPath.row];
  return email;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NAREmailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NAREmailCell" forIndexPath:indexPath];
  NAREmail *email = [self getEmailAtIndexPath:indexPath];
  [cell configureCellWithBody:[email htmlBody]];
  cell.emailTableView = self.tableView;   // memory leak
  cell.email = email;
  
  return cell;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor colorWithRed:108.0f/255.0f green:122.0f/255.0f blue:137.0f/255.0f alpha:1.0f];
  
  UINib *nib = [UINib nibWithNibName:@"NAREmailCell" bundle:nil];
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  
  [self.tableView registerNib:nib forCellReuseIdentifier:@"NAREmailCell"];
}


- (void)fetchEmailsWithUserId:(NSString *)userId threadId:(NSString *)threadId {
  NSString *requestString = [NSString stringWithFormat: @"http://localhost:8080/emails/%@/%@", userId,threadId];

  NSURL *url = [NSURL URLWithString:requestString];
  NSURLRequest *req = [NSURLRequest requestWithURL:url];
  
  NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req
   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
     NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
     dispatch_async(dispatch_get_main_queue(), ^{
       for(NSDictionary *EmailDict in jsonArray) {
         NSString *subject = [EmailDict objectForKey:@"subject"];
         NSString *recipients = [EmailDict objectForKey:@"recipients"];
         NSString *textBody = [EmailDict objectForKey:@"textBody"];
         NSString *htmlBody = [EmailDict objectForKey:@"htmlBody"];
         [self addNewEmailWithSubject:subject recipients:recipients textBody:textBody htmlBody:htmlBody];
       }
     });
   }];
  [dataTask resume];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
  return [self init];
}

@end
