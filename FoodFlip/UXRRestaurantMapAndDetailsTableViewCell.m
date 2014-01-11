//
//  UXRRestaurantMapAndDetailsTableViewCell.m
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRRestaurantMapAndDetailsTableViewCell.h"
#import "UXRGlobals.h"

@implementation UXRRestaurantMapAndDetailsTableViewCell

+ (NSString *)cellIdentifier {
    static NSString* _cellIdentifier = @"UXRRestaurantMapAndDetailsTableViewCell";
    _cellIdentifier = NSStringFromClass([self class]);
    return _cellIdentifier;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self.mapView setUserInteractionEnabled:NO];
    self.websiteLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    self.addressLabel.enabledTextCheckingTypes = NSTextCheckingTypeAddress;
}

-(IBAction)shareButtonAction:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHARE_REQUEST_NOTIFICATION object:nil];
}

#pragma mark - Superclass Overrides

+(CGFloat)preferredCellHeight{
    return 300.0f;
}

@end
