//
//  GiveLiftTableViewController.m
//  Pool It
//
//  Created by Jaden on 06/04/2014.
//  Copyright (c) 2014 Jaden. All rights reserved.
//

#import "GiveLiftTableViewController.h"
#import <Parse/Parse.h>

@interface GiveLiftTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *fromAddressText;
@property (weak, nonatomic) IBOutlet UITextField *toAddressText;
@property (weak, nonatomic) IBOutlet UILabel *seatLeftText;
@property (weak, nonatomic) IBOutlet UITextField *liftTimeText;
@property (weak, nonatomic) IBOutlet UITextField *commentText;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UISwitch *isDailySwitch;
@property (weak, nonatomic) IBOutlet UIStepper *seatLeftStepper;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitLiftButton;

@end

@implementation GiveLiftTableViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// switch to choose if it's a daily lift
- (IBAction)isDailySwitch:(id)sender {
    UISwitch *isDailySwitch = (UISwitch *)sender;
    self.isDaily = [isDailySwitch isOn];
    if (self.isDaily) {
        self.datePicker.datePickerMode = UIDatePickerModeTime;
    }
    else {
        self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    }
}

// choose how many seats left
- (IBAction)seatLeftStepper:(id)sender {
    self.seatLeft = self.seatLeftStepper.value;
    // set the text
    self.seatLeftText.text = [NSString stringWithFormat:@"Seat Left: %d", self.seatLeft];
}

// change date
- (IBAction)changeDatePicker:(id)sender {
    self.liftDate = [self.datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (self.isDaily) {
        [dateFormatter setDateFormat:@"HH:mm"];
    }
    else {
        [dateFormatter setDateFormat:@"dd-MM-yy HH:mm"];
    }
    self.liftTimeText.text = [dateFormatter stringFromDate:self.liftDate];
}

// submit lift
- (IBAction)submitLift:(UIBarButtonItem *)sender {
    if (!self.liftDate || !self.fromAddressText || !self.toAddressText || self.fromAddressText.text.length == 0 || self.toAddressText.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Give a Lift"
                                    message:@"Please input information for the lift."
                                   delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil] show];
    }
    else {
        // disable submit button
        self.submitLiftButton.enabled = NO;
        // edit lift
        if (self.editLift) {
            PFQuery *query = [PFQuery queryWithClassName:@"Lift"];
            [query getObjectInBackgroundWithId:self.editLift.objectId block:^(PFObject *lift, NSError *error) {
                if (!error) {
                    lift[@"fromAddress"] = self.fromAddressText.text;
                    lift[@"toAddress"] = self.toAddressText.text;
                    lift[@"isDaily"] = @(self.isDaily);
                    lift[@"liftDate"] = self.liftDate;
                    lift[@"seatLeft"] = @(self.seatLeft);
                    lift[@"comment"] = self.commentText.text;
                    [lift saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (!error) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    }];
                }
            }];
        }
        // submit lift
        else {
            PFObject *submitLift = [PFObject objectWithClassName:@"Lift"];
            [submitLift setObject:[PFUser currentUser] forKey:@"liftUser"];
            submitLift[@"fromAddress"] = self.fromAddressText.text;
            submitLift[@"toAddress"] = self.toAddressText.text;
            submitLift[@"isDaily"] = @(self.isDaily);
            submitLift[@"liftDate"] = self.liftDate;
            submitLift[@"seatLeft"] = @(self.seatLeft);
            submitLift[@"comment"] = self.commentText.text;
            [submitLift saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

- (void)updateUI
{
    self.seatLeft = 0;
    self.isDaily = YES;
    self.liftTimeText.enabled = NO;
    
    // if it's editing lift, fill the info into ui
    if (self.editLift) {
        // update address
        self.fromAddressText.text = self.editLift[@"fromAddress"];
        self.toAddressText.text = self.editLift[@"toAddress"];
        
        // update isDaily info
        [self.isDailySwitch setOn:[self.editLift[@"isDaily"] boolValue]];
        self.isDaily = [self.editLift[@"isDaily"] boolValue];
        if (self.isDaily) {
            self.datePicker.datePickerMode = UIDatePickerModeTime;
        }
        else {
            self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        }
        
        // update seatLeft info
        self.seatLeft = (int)[self.editLift[@"seatLeft"] integerValue];
        self.seatLeftText.text = [NSString stringWithFormat:@"Seat Left: %d", self.seatLeft];
        self.seatLeftStepper.value = self.seatLeft;
        
        // update comment
        self.commentText.text = self.editLift[@"comment"];
        
        // update date info
        self.liftDate = self.editLift[@"liftDate"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        if (self.isDaily) {
            [dateFormatter setDateFormat:@"HH:mm"];
        }
        else {
            [dateFormatter setDateFormat:@"dd-MM-yy HH:mm"];
        }
        self.liftTimeText.text = [dateFormatter stringFromDate:self.liftDate];
        [self.datePicker setDate:self.liftDate];
    }

}

@end
