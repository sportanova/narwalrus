//
//  NAREmailCell.h
//  narwalrus
//
//  Created by Stephen Portanova on 8/13/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NAREmailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
- (void)configureCellWithBody:(NSString *)body;

@end
