#import <Foundation/Foundation.h>

@interface NARConversation : NSObject
{
    NSString *_subject;
    NSString *_recipients;
}

+ (instancetype)createConversationWithSubject:(NSString *)subject recipients:(NSString *)recipients;

// Designated initializer for NARConversation
- (instancetype)initWithConversationSubject:(NSString *)name recipients:(NSString *)recipients;
- (NSString *)subject;

@end
