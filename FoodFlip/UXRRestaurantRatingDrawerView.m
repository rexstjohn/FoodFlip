//
//  UXRRestaurantRatingDrawerView.m
//  FMag
//
//  Created by Rex St. John on 12/17/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRRestaurantRatingDrawerView.h"

@implementation UXRRestaurantRatingDrawerView

+ (NSString *)viewIdentifier {
    static NSString* _viewIdentifier = @"UXRRestaurantRatingDrawerView";
    _viewIdentifier = NSStringFromClass([self class]);
    return _viewIdentifier;
}

@end
