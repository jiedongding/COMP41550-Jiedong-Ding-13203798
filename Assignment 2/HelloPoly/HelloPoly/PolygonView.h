//
//  PolygonView.h
//  HelloPoly
//
//  Created by Jaden on 24/01/2014.
//  Copyright (c) 2014 UCD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PolygonView;

@interface PolygonView : UIView

@property (nonatomic) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, assign) int numberOfSides;

@end
