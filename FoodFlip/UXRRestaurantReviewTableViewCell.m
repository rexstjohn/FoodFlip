//
//  UXRRestaurantReviewTableViewCell.m
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRRestaurantReviewTableViewCell.h"

@implementation UXRRestaurantReviewTableViewCell

+ (NSString *)cellIdentifier {
    static NSString* _cellIdentifier = @"UXRRestaurantReviewTableViewCell";
    _cellIdentifier = NSStringFromClass([self class]);
    return _cellIdentifier;
}


@end
