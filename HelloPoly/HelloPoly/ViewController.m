//
//  ViewController.m
//  HelloPoly
//
//  Created by Jaden on 24/01/2014.
//  Copyright (c) 2014 UCD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)decrease:(UIButton *)sender
{
    self.model.numberOfSides--;
    [self updateUI];
}

- (IBAction)increase:(UIButton *)sender
{
    self.model.numberOfSides++;
    [self updateUI];
}

- (void)updateUI
{
    self.numberOfSidesLabel.text = [NSString stringWithFormat:@"Number of sides: %d", self.model.numberOfSides];
    [self.polygonView setNumberOfSides:self.model.numberOfSides];
    [self.polygonView setNeedsDisplay];
}

- (void)viewDidLoad
{
    self.model.numberOfSides = [self.numberOfSidesLabel.text integerValue];
    [self updateUI];
}

@end
