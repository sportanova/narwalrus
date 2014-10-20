//
//  NAREmailStore.m
//  narwalrus
//
//  Created by Stephen Portanova on 7/10/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import "NAREmailStore.h"
#import "NAREmail.h"

@interface NAREmailStore()
  @property (nonatomic) NSMutableArray *privateEmails;
@end

@implementation NAREmailStore
+ (instancetype)sharedStore {
  static NAREmailStore *sharedStore = nil;
  
  if (!sharedStore) {
    sharedStore = [[self alloc] initPrivate];
  }
  
  return sharedStore;
}

- (void)deleteStore {
  self.privateEmails = [[NSMutableArray alloc] init];
}

- (instancetype)init {
  @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[NAREmailStore sharedStore]" userInfo:nil];
  return nil;
}

- (instancetype)initPrivate {
  self = [super init];
  if(self) {
    _privateEmails = [[NSMutableArray alloc] init];
  }
  return self;
}

- (NAREmail *)createEmailWithSubject:(NSString *)subject recipientsSet:(NSMutableArray *)recipientsSet threadId:(NSString *)threadId recipientsHash:(NSString *)recipientsHash textBody:(NSString *)textBody htmlBody:(NSString *)htmlBody sender:(NSString *)sender prepend:(bool)prepend messageId:(NSString *)messageId inReplyTo:(NSString *)inReplyTo references:(NSString *)references ts:(NSString *)ts
{
  NAREmail *email = [NAREmail createEmailWithSubject:subject recipientsSet:(NSMutableArray *)recipientsSet threadId:(NSString *)threadId recipientsHash:recipientsHash textBody:textBody htmlBody:htmlBody sender:sender messageId:messageId inReplyTo:inReplyTo references:references ts:ts];
  
  if(prepend == true) {
    [self.privateEmails insertObject:email atIndex:0];
  }
  else {
    [self.privateEmails addObject:email];
  }
  
  return email;
}

- (NSArray *)allEmails {
  return [[self.privateEmails reverseObjectEnumerator] allObjects];
}
@end

