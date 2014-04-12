//
//  LiftDetailViewController.m
//  Pool It
//
//  Created by Jaden on 30/03/2014.
//  Copyright (c) 2014 Jaden. All rights reserved.
//

#import "LiftDetailViewController.h"
#import "LiftMapViewController.h"

@interface LiftDetailViewController ()

@property (nonatomic, strong) PFUser *driverUser;

@end

@implementation LiftDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateLiftInfo];
    
    [self updateDriverInfo];
}

- (void)updateLiftInfo
{
    // from and to
    self.fromLabel.text = [NSString stringWithFormat:@"From: %@", self.detailLift[@"fromAddress"]];
    [self.fromLabel sizeToFit];
    
    self.toLabel.text = [NSString stringWithFormat:@"To: %@", self.detailLift[@"toAddress"]];
    
    BOOL isDaily = [self.detailLift[@"isDaily"] boolValue];
    // daily or not
    if (isDaily) {
        self.dailyLabel.text = @"Daily: YES";
    }
    else {
        self.dailyLabel.text = @"Daily: NO";
    }
    
    // time
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (isDaily) {
        [dateFormatter setDateFormat:@"HH:mm"];
    }
    else {
        [dateFormatter setDateFormat:@"dd-MM-yy HH:mm"];
    }
    self.timeLabel.text = [NSString stringWithFormat:@"Time: %@",[dateFormatter stringFromDate:self.detailLift[@"liftDate"]]];
    
    // seat left
    self.seatLeftLabel.text = [NSString stringWithFormat:@"Seat Left: %ld", (long)[self.detailLift[@"seatLeft"] integerValue]];
    
    // comment
    self.commentLabel.text = [NSString stringWithFormat:@"Comment: %@", self.detailLift[@"comment"]];
}

- (void)updateDriverInfo
{
    PFQuery *query = [PFUser query];
    NSString *liftUserObjectId = ((PFUser *)[self.detailLift objectForKey:@"liftUser"]).objectId;
    [query getObjectInBackgroundWithId:liftUserObjectId block:^(PFObject *object, NSError *error) {
        if (!error) {
            self.driverUser = (PFUser *)object;
            self.fullnameLabel.text = [NSString stringWithFormat:@"Full Name: %@", self.driverUser[@"fullname"]];
            self.contactNumberLabel.text = [NSString stringWithFormat:@"Contact Number: %@", self.driverUser[@"contactNumber"]];
            self.emailLabel.text = [NSString stringWithFormat:@"Email: %@", self.driverUser[@"email"]];
        }
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[LiftMapViewController class]]) {
        LiftMapViewController *liftMapVC = (LiftMapViewController *)segue.destinationViewController;
        [liftMapVC setFromAddress:self.detailLift[@"fromAddress"]];
        [liftMapVC setToAddress:self.detailLift[@"toAddress"]];
    }
}


@end
