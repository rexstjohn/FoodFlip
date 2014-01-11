//
//  NSString+MetersToMiles.m
//  FMag
//
//  Created by Rex St. John on 1/2/14.
//  Copyright (c) 2014 UX-RX. All rights reserved.
//

#import "NSString+MetersToMiles.h"
#import "NSNumber+Rounding.h"

@implementation NSString (MetersToMiles)
+(NSString*)milesStringFromMeters:(NSNumber*)meters{
    CGFloat milesPerMeter = 0.000621371;
    CGFloat metersDistance = [meters floatValue];
    CGFloat miles = milesPerMeter * metersDistance;
    NSString *resultString;
    
    NSNumber *roundedDistance = [NSNumber roundNumber:[NSNumber numberWithFloat:miles] toNearestNumber:[NSNumber numberWithFloat:0.1f]];
    
    // Correct for zero values.
    if([roundedDistance floatValue] <= 0.1f){
        roundedDistance = [NSNumber numberWithFloat:0.1f];
    }
    
    resultString = [NSString stringWithFormat:@"~%@ miles away", [NSNumber roundNumber:roundedDistance toDecimals:2]];
    return resultString;
}
@end
