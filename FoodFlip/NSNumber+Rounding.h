//
//  NSNumber+Rounding.h
//  FMag
//
//  Created by Rex St. John on 1/2/14.
//  Copyright (c) 2014 UX-RX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Rounding)

+(NSNumber*)roundNumber:(NSNumber*)number toNearestNumber:(NSNumber*)nearest;
+(NSString*)roundNumber:(NSNumber*)number toDecimals:(int)decimals;
@end
