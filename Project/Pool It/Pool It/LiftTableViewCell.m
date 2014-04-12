//
//  LiftTableViewCell.m
//  Pool It
//
//  Created by Jaden on 10/04/2014.
//  Copyright (c) 2014 Jaden. All rights reserved.
//

#import "LiftTableViewCell.h"

@implementation LiftTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
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
