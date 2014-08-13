//
//  NAREmailCell.m
//  narwalrus
//
//  Created by Stephen Portanova on 8/13/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import "NAREmailCell.h"

@implementation NAREmailCell

- (void)configureCellWithBody:(NSString *)body
{
  self.bodyLabel.text = body;
  self.bodyLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:12.0f];
//  [self setTranslatesAutoresizingMaskIntoConstraints:NO];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
