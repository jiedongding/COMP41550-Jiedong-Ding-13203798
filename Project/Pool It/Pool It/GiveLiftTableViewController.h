//
//  GiveLiftTableViewController.h
//  Pool It
//
//  Created by Jaden on 06/04/2014.
//  Copyright (c) 2014 Jaden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface GiveLiftTableViewController : UITableViewController

@property (nonatomic, strong) PFObject *editLift;

@property BOOL isDaily;
@property int seatLeft;
@property (nonatomic, strong) NSDate *liftDate;

@end
