//
//  PolygonView.m
//  HelloPoly
//
//  Created by Jaden on 24/01/2014.
//  Copyright (c) 2014 UCD. All rights reserved.
//

#import "PolygonView.h"

@implementation PolygonView

- (void)initPropertiesToDefaultValues
{
    self.fillColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    self.strokeColor = [UIColor blackColor];
    self.lineWidth = 2.0;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initPropertiesToDefaultValues];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGRect insetRect = CGRectInset(rect, self.lineWidth / 2, self.lineWidth / 2);
    NSArray *points = [self pointsForPolygonInRect:insetRect numberOfSides: self.numberOfSides];
    
    if (points.count > 2)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
        CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGPoint aPoint =  [points[0] CGPointValue];
        CGContextMoveToPoint(context, aPoint.x, aPoint.y);
        for (int i = 1; i < points.count; i++)
        {
            aPoint =  [points[i] CGPointValue];
            CGContextAddLineToPoint(context, aPoint.x, aPoint.y);
        }
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
    }

}

- (NSArray *)pointsForPolygonInRect:(CGRect)rect numberOfSides:(int)numberOfSides
{
    CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0);
    float radius = 0.9 * center.x;
    NSMutableArray *result = [NSMutableArray array];
    float angle = (2.0 * M_PI) / numberOfSides;
    float exteriorAngle = M_PI - angle;
    float rotationDelta = angle - (0.5 * exteriorAngle);
    
    for (int currentAngle = 0; currentAngle < numberOfSides; currentAngle++) {
        float newAngle = (angle * currentAngle) - rotationDelta;
        float curX = cos(newAngle) * radius;
        float curY = sin(newAngle) * radius;
        [result addObject:[NSValue valueWithCGPoint:CGPointMake(center.x+curX, center.y+curY)]];
    }
    return result;
}

@end
