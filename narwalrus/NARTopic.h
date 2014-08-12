//
//  NARTopic.h
//  narwalrus
//
//  Created by Stephen Portanova on 8/12/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NARTopic : NSObject

+ (instancetype)createConversationWithSubject:(NSString *)subject recipientsHash:(NSString *)hash
                                   recipients:(NSString *)recipients;

// Designated initializer for NARConversation
- (instancetype)initWithConversationSubject:(NSString *)name recipientsHash:(NSString *)hash recipients:(NSString *)recipients;

@end
