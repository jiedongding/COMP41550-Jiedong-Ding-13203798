//
//  ChangePwdViewController.m
//  Pool It
//
//  Created by Jaden on 09/04/2014.
//  Copyright (c) 2014 Jaden. All rights reserved.
//

#import "ChangePwdViewController.h"
#import <Parse/Parse.h>

@interface ChangePwdViewController () <UITextFieldDelegate>

@end

@implementation ChangePwdViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)submitChangePwd:(UIBarButtonItem *)sender {
    
    if ([self.changedPwdTextField.text isEqualToString:self.confirmPwdTextField.text]) {
        PFUser *user = [PFUser currentUser];
        user.password = self.confirmPwdTextField.text;
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    else {
        [[[UIAlertView alloc] initWithTitle:@"Change Password"
                                    message:@"Password Different"
                                   delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil] show];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
