//
//  ViewController.m
//  Pool It
//
//  Created by Jaden on 28/03/2014.
//  Copyright (c) 2014 Jaden. All rights reserved.
//

#import "ViewController.h"
#import "LiftListTableViewController.h"
#import "GiveLiftTableViewController.h"
#import "LoginViewController.h"
#import "SignUpViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]) {
        // Instantiate custom login view controller
        LoginViewController *login = [[LoginViewController alloc] init];
        login.fields = ~(PFLogInFieldsDismissButton | PFLogInFieldsFacebook | PFLogInFieldsTwitter); // Disable cancel, facebook, twitter
        login.delegate = self;
        
        // Instantiate custom sign up view controller
        SignUpViewController *signUp = [[SignUpViewController alloc] init];
        signUp.delegate = self;
        
        // Link the sign up view controller
        [login setSignUpController:signUp];
        
        // Present login view controller
        [self presentViewController:login animated:YES completion:NULL];
    }
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:NULL]; // Dismiss the PFLoginViewController
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL]; // Dismiss the PFSignUpViewController
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"Give a Lift"]) {
        PFUser *user = [PFUser currentUser];
        // if no fullname and contact number
        if (user[@"fullname"] == nil || user[@"contactNumber"] == nil || [user[@"fullname"] length] == 0 || [user[@"contactNumber"] length] == 0) {
            [[[UIAlertView alloc] initWithTitle:@"Give a Lift"
                                        message:@"Please set your fullname and contact number in the settings first then you can give others a lift, thanks."
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil] show];
            return NO;
        }
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // take a lift showing the list of lifts
    if ([segue.destinationViewController isKindOfClass:[LiftListTableViewController class]]) {
        LiftListTableViewController *liftListTVC = (LiftListTableViewController *)segue.destinationViewController;
        liftListTVC.title = @"Lift List";
    }
    if ([segue.destinationViewController isKindOfClass:[GiveLiftTableViewController class]]) {
        GiveLiftTableViewController *giveLiftTVC = (GiveLiftTableViewController *)segue.destinationViewController;
        giveLiftTVC.title = @"Give a Lift";
    }
}

@end
