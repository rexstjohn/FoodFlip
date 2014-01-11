//
//  UXRRestaurantRatingDrawerView.h
//  FMag
//
//  Created by Rex St. John on 12/17/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UXRSmartView.h"
#import <MapKit/MapKit.h>

@interface UXRRestaurantRatingDrawerView : UXRSmartView<MKMapViewDelegate, UIScrollViewDelegate>
@property(nonatomic,strong) IBOutlet UIScrollView *scrollView;
@end
