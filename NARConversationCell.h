//
//  NARConversationCell.h
//  narwalrus
//
//  Created by Stephen Portanova on 8/8/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NARConversationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *recipientsLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *recipientCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *recipientsIcon;

@end
