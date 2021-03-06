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
#import "NAREmail.h"
#import "NAREmailStore.h"

@interface NARConversationsViewController()
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, assign) BOOL isRefreshing;
@end

@implementation NARConversationsViewController
@synthesize userId = _userId;
@synthesize refreshControl = _refreshControl;

- (instancetype)init {
  self = [super initWithStyle:UITableViewStylePlain];
  
  NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
  self.session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
  
  self.userId = [(NARAppDelegate *)[[UIApplication sharedApplication] delegate] userId];
  self.serverUrl = [(NARAppDelegate *)[[UIApplication sharedApplication] delegate] serverUrl];
  
  [self fetchConversationsWithTime:nil deleteStore:true];

  return self;
}

// on tap, show emails
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSArray *conversations = [[NARConversationStore sharedStore] allConversations];
  NARConversation *conversation = conversations[indexPath.row];
  
  NARTopicsTableViewController *topicsVC = [[NARTopicsTableViewController alloc] initWithConversation:conversation userId:self.userId];

  [self.navigationController pushViewController:topicsVC animated:YES];
}

- (NARConversation *)addNewConversationWithSubject:(NSString *)subject recipientsHash:(NSString *)recipientsHash recipients:(NSDictionary *)recipients emailAccountId:(NSString *)emailAccountId topicCount:(NSInteger)topicCount emailCount:(NSInteger)emailCount ts:(NSString *)ts
{
  NARConversation *newConversation = [[NARConversationStore sharedStore] createConversationWithRecipientsHash:recipientsHash recipients:recipients emailAccountId:emailAccountId topicCount:topicCount emailCount:emailCount ts:ts];
  
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
  
  cell.recipientsLabel.text = [conversation recipientsNames];
  cell.recipientsLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:18.0f];
  
  NSInteger recipientCount = (unsigned long)[[conversation recipientsEmailAddresses] count];
  cell.recipientCountLabel.text = [NSString stringWithFormat:@"%lu", (long)recipientCount];
  
  cell.topicCountLabel.text = [NSString stringWithFormat:@"%d", conversation.topicCount];
  cell.emailCountLabel.text = [NSString stringWithFormat:@"%d", conversation.emailCount];

  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 70.0;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.refreshControl = [[UIRefreshControl alloc] init];
  [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
  [self.tableView addSubview:self.refreshControl];
  
  self.view.backgroundColor = [UIColor colorWithRed:108.0f/255.0f green:122.0f/255.0f blue:137.0f/255.0f alpha:1.0f];

  UINib *nib = [UINib nibWithNibName:@"NARConversationCell" bundle:nil];
//  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
  self.tableView.separatorColor = [UIColor colorWithRed:44.0f/255.0f green:62.0f/255.0f blue:80.0f/255.0f alpha:1.0f];;
  self.tableView.separatorInset = UIEdgeInsetsZero;
  
  [self.tableView registerNib:nib forCellReuseIdentifier:@"NARConversationCell"];
}

- (void)refresh:(id)sender
{
  [self fetchConversationsWithTime:nil deleteStore:true];
}

- (void)fetchConversationsWithTime:(NSString *)time deleteStore:(BOOL)deleteStore
{
  NSMutableString *requestString = nil;
  if(time != nil) {
    requestString = [NSMutableString stringWithFormat:@"%@/conversations/ordered/%@?ts=%@", self.serverUrl, self.userId, time];
  }
  else {
    requestString = [NSMutableString stringWithFormat:@"%@/conversations/ordered/%@", self.serverUrl, self.userId];
  }
  NSURL *url = [NSURL URLWithString:requestString];
  NSURLRequest *req = [NSURLRequest requestWithURL:url];
  
  NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req
  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NARConversationsViewController * __weak weakSelf = self;
    NARConversationStore * __weak weakConvStore = [NARConversationStore sharedStore];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      if(deleteStore == true) {
        [weakConvStore deleteStore];
      }
      [weakSelf.tableView reloadData];

      for(NSDictionary *conversationDict in jsonArray) {
        NSString *subject = [conversationDict objectForKey:@"subject"];
        NSString *recipientsHash = [conversationDict objectForKey:@"recipientsHash"];

        NSDictionary *recipients = [conversationDict objectForKey:@"recipients"];
        NSString *emailAccountId = [conversationDict objectForKey:@"emailAccountId"];
        NSInteger topicCount = [[conversationDict objectForKey:@"topicCount"] integerValue];
        NSInteger emailCount = [[conversationDict objectForKey:@"emailCount"] integerValue];
        NSString *ts = [conversationDict objectForKey:@"ts"];

        [weakSelf addNewConversationWithSubject:subject recipientsHash:recipientsHash recipients:recipients emailAccountId:emailAccountId topicCount:topicCount emailCount:emailCount ts:ts];
       }

       [weakSelf.refreshControl endRefreshing];
       [weakSelf.tableView reloadData];
       weakSelf.isRefreshing = false;
     });
   }];
  [dataTask resume];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
  return [self init];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  CGFloat actualPosition = scrollView.contentOffset.y;
  CGFloat contentHeight = scrollView.contentSize.height - 600;
  if (actualPosition >= contentHeight && contentHeight != -600 && self.isRefreshing == false) {
    NSString *lastConversationTime = [[[[NARConversationStore sharedStore] allConversations] lastObject] ts];

    [self fetchConversationsWithTime:lastConversationTime deleteStore:false];
    self.isRefreshing = true;
  }
}

@end
