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
  [self.prototypeCell configureCellWithBody:[[self getEmailAtIndexPath:indexPath] body]];
  [self.prototypeCell layoutIfNeeded];
//  NSString *bodyText = self.prototypeCell.bodyLabel.text;
//  NSLog(@"bodyText: %@", bodyText);
  
  CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
  NSLog(@"height: %f", size.height);
  return size.height+1;
}

- (NAREmailCell *)prototypeCell
{
  if (!_prototypeCell)
  {
    _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"NAREmailCell"];
  }
  return _prototypeCell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"GETTING HERE");
  return UITableViewAutomaticDimension;
}

- (void)viewDidDisappear:(BOOL)animated {
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

- (NAREmail *)getEmailAtIndexPath:(NSIndexPath *)indexPath
{
  NSArray *emails = [[NAREmailStore sharedStore] allEmails];
  NAREmail *email = emails[indexPath.row];
  return email;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NAREmailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NAREmailCell" forIndexPath:indexPath];
  NAREmail *email = [self getEmailAtIndexPath:indexPath];
  [cell configureCellWithBody:[email body]];
//  NSLog(@"BODYLABEL: %@", cell.bodyLabel.text);
  CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
  NSLog(@"CELL HEIGHT: %f", size.height);

  
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
         NSString *body = [EmailDict objectForKey:@"body"];
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
