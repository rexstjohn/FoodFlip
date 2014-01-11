//
//  UXRRestaurantPrimaryTableViewCell+Binding.m
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRRestaurantPrimaryTableViewCell+Binding.h"
#import "UXRBaseRestaurantModel.h"
#import "UXRLocationDataManager.h"
#import "UXRStarBarView.h"
#import "UXRFourSquareRestaurantModel.h"
#import "UXRFourSquareDataManager.h"
#import "NSString+MetersToMiles.h"

@implementation UXRRestaurantPrimaryTableViewCell (Binding)

-(void)bindToRestaurantModel:(id<UXRBaseRestaurantModel>)model{
    self.restaurantNameLabel.text = [model displayName];
    
    // Open now?
    NSString *openNow = ([model restaurantIsOpenNow] == YES)?@"Open Now":@"Closed";
    self.openNowLabel.text = openNow;
    
    // Set distance.
    CLLocation *currentLocation = [[UXRLocationDataManager sharedManager] lastTrackedLocation];
    CLLocationDistance distance = [currentLocation distanceFromLocation:[model restaurantLocation]];
    
    // Calculate a pretty distance.
    NSString *distanceString = [NSString milesStringFromMeters:[NSNumber numberWithFloat:distance]];
    distanceString = [distanceString stringByReplacingOccurrencesOfString:@"0.11" withString:@"0.1"];
    self.distanceLabel.text = distanceString;
    
    // Bind rating.
    UXRFourSquareRestaurantModel *rm = (UXRFourSquareRestaurantModel*)model;
    CGFloat adjustedRating = round(([rm.rating floatValue] / 2) * 2.0) / 2.0;
    [self.starBar setStarRating:adjustedRating];
    
    // Bind query label.
    NSString *queryString =[[UXRFourSquareDataManager sharedManager] getQueryString];
    if([queryString isEqualToString:@""] || queryString == nil){
        queryString = @"Food";
    }
    self.queryLabel.text = [queryString capitalizedString];
    
    // Fill in the default string.
    NSString *initialString = [[UXRFourSquareDataManager sharedManager] getLocationString];
    self.locationTextField.text = ([initialString isEqualToString:@""] == YES || initialString == nil)?@"Nearby":[initialString capitalizedString];
}

@end
