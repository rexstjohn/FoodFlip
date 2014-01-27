//
//  UXRRestaurantHoursTableViewCell_iPhone.m
//  FoodFlip
//
//  Created by Rex St. John on 1/26/14.
//  Copyright (c) 2014 UX-RX. All rights reserved.
//

#import "UXRRestaurantHoursTableViewCell_iPhone.h"

@implementation UXRRestaurantHoursTableViewCell_iPhone

+ (NSString *)cellIdentifier {
    static NSString* _cellIdentifier = @"UXRRestaurantHoursTableViewCell_iPhone.h";
    _cellIdentifier = NSStringFromClass([self class]);
    return _cellIdentifier;
}

+(CGFloat)preferredCellHeight{
    return 175.0f;
}


@end
