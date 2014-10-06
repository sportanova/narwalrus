//
//  NAREmailVCViewController.h
//  narwalrus
//
//  Created by Stephen Portanova on 9/7/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NARTopic;
@class NAREmailCell;
@class NAREmail;

@protocol EmailCellDelegate <NSObject>
@optional
- (void)refreshTable;
@optional
- (void)setLastResizeTime:(double)time;
@optional
- (double)getLastResizeTime;
@optional
- (void)flipFullSize;
@end

@protocol EmailVCParentDelegate <NSObject>
- (NAREmail *)addNewEmailWithSubject:(NSString *)subject recipientsSet:(NSMutableArray *)recipientsSet recipientsHash:(NSString *)recipientsHash textBody:(NSString *)textBody htmlBody:(NSString *)htmlBody sender:(NSDictionary *)sender prepend:(bool)prepend;
- (NSString *)getEmailAccountId;
@end

@interface NAREmailVCViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, EmailCellDelegate, UIGestureRecognizerDelegate, EmailVCParentDelegate>
@property(strong, atomic) NSURLSession *session;
@property(strong,atomic) NARTopic *topic;
@property(strong,atomic) NSString *userId;
@property(strong, nonatomic) NSString *emailAccountId;
@property (assign, atomic) double lastResizeTime;
@property(weak, atomic) NSString *serverUrl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

- (instancetype)initWithTopic:(NARTopic *)topic userId:(NSString *)userId emailAccountId:(NSString *)emailAccountId;
@end
