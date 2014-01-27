//
//  UXRRestaurantPrimaryTableViewCell_iPhone.m
//  FoodFlip
//
//  Created by Rex St. John on 1/26/14.
//  Copyright (c) 2014 UX-RX. All rights reserved.
//

#import "UXRRestaurantPrimaryTableViewCell_iPhone.h"

@implementation UXRRestaurantPrimaryTableViewCell_iPhone

+ (NSString *)cellIdentifier {
    static NSString* _cellIdentifier = @"UXRRestaurantPrimaryTableViewCell_iPhone";
    _cellIdentifier = NSStringFromClass([self class]);
    return _cellIdentifier;
}

+(CGFloat)preferredCellHeight{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = (UIInterfaceOrientationIsLandscape(orientation) == NO)? screenRect.size.height: screenRect.size.width;
    return screenHeight + 20;
}

@end
