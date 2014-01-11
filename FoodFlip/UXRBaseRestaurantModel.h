//
//  UXRBaseRestaurantModel.h
//  FMag
//
//  Created by Rex St. John on 12/20/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol UXRBaseRestaurantModel
-(NSURL*)primaryPhotoURL;
-(NSString*)displayName;
-(NSString*)restaurantIdentifier;
-(NSNumber*)priceRating;
-(NSNumber*)reviewCountTotal;
-(NSString*)readiblePhoneNumber;
-(NSString*)primaryRestaurantWebsiteURLPathString;
-(NSString*)readibleAddressString;
-(NSString*)readibleCityStateString;
-(NSArray*)restaurantPhotosArray;
-(CLLocation*)restaurantLocation;
-(BOOL)restaurantIsOpenNow;
-(NSInteger)numberOfReviews;
-(NSArray*)restaurantReviewsArray;
@end
