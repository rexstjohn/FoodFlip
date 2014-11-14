//
//  UIColor+SimpleColoring.m
//  UXRX
//
//  Created by Rex St John on 1/18/13.
//  Copyright (c) 2013 UXRX. All rights reserved.
//

#import "UIColor+SimpleColoring.h"

@implementation UIColor (SimpleColoring)

static CGFloat sColorRange = 256.0;

+(UIColor*)simpleColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:red/sColorRange green:green/sColorRange blue:blue/sColorRange alpha:alpha];
}

@end
