//
//  NSNumber+Rounding.m
//  FMag
//
//  Created by Rex St. John on 1/2/14.
//  Copyright (c) 2014 UX-RX. All rights reserved.
//

#import "NSNumber+Rounding.h"
#import <math.h>

@implementation NSNumber (Rounding)

+(NSNumber*)roundNumber:(NSNumber*)number toNearestNumber:(NSNumber*)nearest{
    CGFloat floatNumber = [number floatValue];
    CGFloat nearestNumber = [nearest floatValue];
    int multiplier = floor(floatNumber / nearestNumber);
    return [NSNumber numberWithFloat:multiplier * nearestNumber];
}

+(NSString*)roundNumber:(NSNumber*)number toDecimals:(int)decimals{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle]; 
    [formatter setMaximumFractionDigits:decimals];
    [formatter setRoundingMode: NSNumberFormatterRoundUp];
    NSString *numberString = [formatter stringFromNumber:number];
    return numberString;
}

@end
