//
//  ViewController.h
//  HelloPoly
//
//  Created by Jaden on 24/01/2014.
//  Copyright (c) 2014 UCD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolygonShape.h"
#import "PolygonView.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *numberOfSidesLabel;
@property (strong, nonatomic) IBOutlet PolygonShape *model;
@property (weak, nonatomic) IBOutlet PolygonView *polygonView;

- (IBAction)decrease:(UIButton *)sender;
- (IBAction)increase:(UIButton *)sender;


@end
