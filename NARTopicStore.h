//
//  NARTopicStore.h
//  narwalrus
//
//  Created by Stephen Portanova on 8/12/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NARTopic;

@interface NARTopicStore : NSObject
@property (nonatomic, readonly) NSArray *allTopics;
- (void)deleteStore;
+ (instancetype)sharedStore;
- (NARTopic *)createTopicWithSubject:(NSString *)subject threadId:(NSString *)threadId emailCount:(NSInteger)emailCount;
@end
