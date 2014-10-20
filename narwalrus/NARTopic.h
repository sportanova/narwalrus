//
//  NARTopic.h
//  narwalrus
//
//  Created by Stephen Portanova on 8/12/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NARTopic : NSObject
@property NSString *subject;
@property NSString *threadId;
@property NSInteger emailCount;
@property NSString *ts;

+ (instancetype)createTopicWithSubject:(NSString *)subject threadId:(NSString *)threadId emailCount:(NSInteger)emailCount ts:(NSString *)ts;

// Designated initializer for NARTopic
- (instancetype)initWithTopicSubject:(NSString *)subject threadId:(NSString *)threadId emailCount:(NSInteger)emailCount ts:(NSString *)ts;

@end
