//
//  UpdateInfoViewController.m
//  Pool It
//
//  Created by Jaden on 09/04/2014.
//  Copyright (c) 2014 Jaden. All rights reserved.
//

#import "UpdateInfoViewController.h"
#import <Parse/Parse.h>

@interface UpdateInfoViewController () <UITextFieldDelegate>

@end

@implementation UpdateInfoViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PFUser *user = [PFUser currentUser];
    self.emailTextField.text = user.email;
    
    if (user[@"fullname"] != nil) {
        self.fullnameTextField.text = user[@"fullname"];
    }
    if (user[@"contactNumber"] != nil) {
        self.contactNumberTextField.text = user[@"contactNumber"];
    }
}

- (IBAction)submitUpdateInfo:(UIBarButtonItem *)sender {
    PFUser *user = [PFUser currentUser];
    
    user.email = self.emailTextField.text;
    user[@"fullname"] = self.fullnameTextField.text;
    user[@"contactNumber"] = self.contactNumberTextField.text;
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
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
