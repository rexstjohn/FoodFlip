//
//  UXRYelpRestaurantLocationModel.m
//  FMag
//
//  Created by Rex St. John on 12/19/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRYelpRestaurantLocationModel.h"

@implementation UXRYelpRestaurantLocationModel

- (void) setCoordinate:(id)coordinate {
    if (nil == coordinate) {
        _latitude = nil;
        _longitude = nil;
    } else if ([coordinate isKindOfClass:[NSDictionary class]]) {
        _latitude = [coordinate objectForKey:@"latitude"];
        _longitude = [coordinate objectForKey:@"longitude"];
    }
}

-(BOOL)isModelValid{
    BOOL isValid = YES;
    
    isValid = self.state_code != nil;
    isValid = self.country_code != nil;
    isValid = self.display_address != nil;
    
    return isValid;
}
@end
