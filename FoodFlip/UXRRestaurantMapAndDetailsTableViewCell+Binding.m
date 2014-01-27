//
//  UXRRestaurantMapAndDetailsTableViewCell+Binding.m
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRRestaurantMapAndDetailsTableViewCell+Binding.h"
#import "UXRBaseRestaurantModel.h"
#import "UXRRestaurantMapAnnotation.h"
#import "MKMapView+Zooming.h"
#import <MapKit/MapKit.h>

@implementation UXRRestaurantMapAndDetailsTableViewCell (Binding)

-(void)bindToRestaurantModel:(id<UXRBaseRestaurantModel>)model{
    
    // Map config.
    [self.mapView removeAnnotations:self.mapView.annotations];
    UXRRestaurantMapAnnotation *annotation = [[UXRRestaurantMapAnnotation alloc] init];
    CLLocation *location = [model restaurantLocation];
    annotation.coordinate = location.coordinate;
    annotation.title = [model displayName];
    [self.mapView addAnnotation:annotation];
    [self.mapView zoomToLocation:[model restaurantLocation] withMarginInMiles:0.5f animated:NO];
   
    // Details
    self.reviewCountLabel.text = [NSString stringWithFormat:@"Tips: %@",[[model reviewCountTotal] stringValue]];
    self.phoneLabel.text = [NSString stringWithFormat:@"Phone: %@",[model readiblePhoneNumber]];
    self.websiteLabel.text = [NSString stringWithFormat:@"%@",[model primaryRestaurantWebsiteURLPathString]];
    
    //
    self.addressLabel.text = [NSString stringWithFormat:@"%@ - %@",[model readibleAddressString],[model readibleCityStateString]];
    
    // Set the price.
    NSMutableString *priceString = [[NSMutableString alloc] init];
    
    for(int i = 0; i < [[model priceRating] intValue]; i++){
        priceString = (NSMutableString*)[priceString stringByAppendingString:@"$"];
    }
    
    self.priceLabel.text = [NSString stringWithFormat:@"Price: %@",priceString];
    
}

@end
