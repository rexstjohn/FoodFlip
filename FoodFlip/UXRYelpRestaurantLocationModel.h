//
//  UXRYelpRestaurantLocationModel.h
//  FMag
//
//  Created by Rex St. John on 12/19/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRBaseModel.h"

/*
 address =         (
 );
 city = Seattle;
 coordinate =         {
 latitude = "47.6084921";
 longitude = "-122.336407";
 };
 "country_code" = US;
 "display_address" =         (
 Downtown,
 "Seattle, WA 98101"
 );
 "geo_accuracy" = 5;
 neighborhoods =         (
 Downtown
 );
 "postal_code" = 98101;
 "state_code" = WA;
 */

@interface UXRYelpRestaurantLocationModel : UXRBaseModel

@property(nonatomic,strong) NSString *city;
@property(nonatomic,strong) NSNumber *latitude;
@property(nonatomic,strong) NSNumber *longitude;
@property(nonatomic,strong) NSString *state_code;
@property(nonatomic,strong) NSString *country_code;
@property(nonatomic,strong) NSArray *display_address;
@property(nonatomic,strong) NSArray *address;
@property(nonatomic,strong) NSNumber *postal_code;
@property(nonatomic,strong) NSArray *neighborhoods;

@end
