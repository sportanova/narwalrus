//
//  NAREmailVCViewController.m
//  narwalrus
//
//  Created by Stephen Portanova on 9/7/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import "NAREmailVCViewController.h"
#import "NARConversationsViewController.h"
#import "NAREmailStore.h"
#import "NAREmail.h"
#import "NARTopic.h"
#import "NARConversation.h"
#import "NAREmailCell.h"
#import "NARAppDelegate.h"
#import "NARSendMessageViewController.h"

@interface NAREmailVCViewController ()

@end

@implementation NAREmailVCViewController
@synthesize topic = _topic;
@synthesize lastResizeTime = _lastResizeTime;
@synthesize userId = _userId;

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
  
  UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] init];
  [singleTap setNumberOfTapsRequired:1];
  [singleTap setDelegate:self];
  [singleTap addTarget:self action:@selector(handleSingleTap:)];

  [self.messageLabel setUserInteractionEnabled:YES];
  [self.messageLabel addGestureRecognizer:singleTap];
  self.messageLabel.layer.cornerRadius = 10.0f;

  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  UINib *nib = [UINib nibWithNibName:@"NAREmailCell" bundle:nil];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"NAREmailCell"];
  
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NAREmail *email = [self getEmailAtIndexPath:(NSIndexPath *)indexPath];
  
  NSInteger height = 100;
  
  if(email.isFullSize == 1) {
    height = email.fullSize + 50;
  }
  
  return height;
}

- (void)refreshTable
{
  NSIndexPath *durPath = [NSIndexPath indexPathForRow:0 inSection:0];
  NSArray *paths = [NSArray arrayWithObject:durPath];
  
  [self.tableView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationNone];
}

- (void)viewDidDisappear:(BOOL)animated {
  if ([self.navigationController.viewControllers indexOfObject:self] == 0) {
    [[NAREmailStore sharedStore] deleteStore];
  }
  
  [super viewDidDisappear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSLog(@"NAR EMAIL count: %lu", (unsigned long)[[[NAREmailStore sharedStore] allEmails] count]);
  return [[[NAREmailStore sharedStore] allEmails] count];
}

- (NAREmail *)getEmailAtIndexPath:(NSIndexPath *)indexPath
{
  NSArray *emails = [[NAREmailStore sharedStore] allEmails];
  NAREmail *email = emails[indexPath.row];
  return email;
}

- (double)getLastResizeTime {
  return self.lastResizeTime;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NAREmailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NAREmailCell" forIndexPath:indexPath];
  NAREmail *email = [self getEmailAtIndexPath:indexPath];
  
  [cell configureCellWithBody:[email htmlBody] sender:[email sender]];
  cell.email = email;
  
  cell.delegate = self;
  cell.emailDelegate = email;
  
  return cell;
}

- (instancetype)initWithTopic:(NARTopic *)topic userId:(NSString *)userId {
  self = [super init];
  
  self.topic = topic;
  self.userId = userId;
  self.serverUrl = [(NARAppDelegate *)[[UIApplication sharedApplication] delegate] serverUrl];
  
  self.lastResizeTime = CACurrentMediaTime();
  
  NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
  self.session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
  
  [self fetchEmailsWithUserId:self.userId threadId:self.topic.threadId];
  
  return self;
}

- (NAREmail *)addNewEmailWithSubject:(NSString *)subject recipients:(NSString *)recipients textBody:(NSString *)textBody
                            htmlBody:(NSString *)htmlBody sender:(NSString *)sender
{
  NAREmail *newEmail = [[NAREmailStore sharedStore] createEmailWithSubject:subject recipients:recipients textBody:textBody htmlBody:htmlBody sender:(NSString *)sender];
  
  NSInteger lastRow = [[[NAREmailStore sharedStore] allEmails] indexOfObject:newEmail];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
  
  [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
  
  return newEmail;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
  if (sender.state == UIGestureRecognizerStateEnded) {
    NARSendMessageViewController *sendVC = [[NARSendMessageViewController alloc] init];
    [self.navigationController pushViewController:sendVC animated:YES];
  }
}

- (void)fetchEmailsWithUserId:(NSString *)userId threadId:(NSString *)threadId {
  NSString *requestString = [NSString stringWithFormat: @"%@/emails/%@/%@", self.serverUrl, userId,threadId];
  
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
         NSString *sender = [EmailDict objectForKey:@"sender"];
         
         [self addNewEmailWithSubject:subject recipients:recipients textBody:textBody htmlBody:htmlBody sender:sender];
       }
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
