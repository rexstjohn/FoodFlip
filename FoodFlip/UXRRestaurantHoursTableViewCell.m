//
//  UXRRestaurantHoursTableViewCell.m
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRRestaurantHoursTableViewCell.h"

@implementation UXRRestaurantHoursTableViewCell

+ (NSString *)cellIdentifier {
    static NSString* _cellIdentifier = @"UXRRestaurantHoursTableViewCell";
    _cellIdentifier = NSStringFromClass([self class]);
    return _cellIdentifier;
}

+(CGFloat)preferredCellHeight{
    return 175.0f;
}

@end
