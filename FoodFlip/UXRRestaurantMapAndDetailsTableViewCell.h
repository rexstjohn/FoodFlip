//
//  UXRRestaurantMapAndDetailsTableViewCell.h
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRSmartTableViewCell.h"
#import <MapKit/MapKit.h>
#import "UXRLabel.h"
#import "UXRButton.h"
#import "UXRAttributedLabel.h"
#import "UXRBaseRestaurantDetailsTableViewCell.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>

@interface UXRRestaurantMapAndDetailsTableViewCell : UXRBaseRestaurantDetailsTableViewCell <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UXRLabel *priceLabel;
@property (weak, nonatomic) IBOutlet UXRLabel *reviewCountLabel;
@property (weak, nonatomic) IBOutlet UXRButton *shareButton;
@property (weak, nonatomic) IBOutlet UXRLabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UXRAttributedLabel *websiteLabel;
@property (weak, nonatomic) IBOutlet UXRAttributedLabel *addressLabel;

@end
