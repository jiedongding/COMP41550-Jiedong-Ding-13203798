//
//  SignUpViewController.m
//  Pool It
//
//  Created by Jaden on 12/04/2014.
//  Copyright (c) 2014 Jaden. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *logo = [UIImage imageNamed:@"Logo"];
    self.signUpView.logo = [[UIImageView alloc] initWithImage:logo];
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
