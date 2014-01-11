//
//  UXRRestaurantMapAnnotation.h
//  FMag
//
//  Created by Rex St. John on 12/19/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface UXRRestaurantMapAnnotation : NSObject<MKAnnotation>

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString * title;
@property(nonatomic, copy) NSString * subtitle;
@property(nonatomic, copy) NSString * imageName;

@end
