//
//  NARConversationStore.h
//  narwalrus
//
//  Created by Stephen Portanova on 7/7/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NARConversation;

@interface NARConversationStore : NSObject
  @property (nonatomic, readonly) NSArray *allConversations;
  + (instancetype)sharedStore;
- (NARConversation *)createConversationWithRecipientsHash:(NSString *)recipientsHash
  recipients:(NSString *)recipients;
@end
