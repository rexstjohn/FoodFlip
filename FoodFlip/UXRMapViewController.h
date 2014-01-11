//
//  UXRMapViewController.h
//  FMag
//
//  Created by Rex St. John on 12/18/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UXRSearchDataProvider.h"
#import "UXRSearchDataReciever.h"

@interface UXRMapViewController : GAITrackedViewController <MKMapViewDelegate, UXRSearchDataReciever>
@property(nonatomic,strong) IBOutlet MKMapView *mapView;
@end
