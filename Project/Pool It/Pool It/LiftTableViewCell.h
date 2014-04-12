//
//  LiftTableViewCell.h
//  Pool It
//
//  Created by Jaden on 10/04/2014.
//  Copyright (c) 2014 Jaden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiftTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellFromLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellToLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellDailyLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellSeatLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellTimeLabel;

@end
