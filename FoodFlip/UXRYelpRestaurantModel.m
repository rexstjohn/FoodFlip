//
//  UXRYelpRestaurantModel.m
//  FMag
//
//  Created by Rex St. John on 12/19/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRYelpRestaurantModel.h"
#import "UXRYelpReviewModel.h"
#import <CoreLocation/CoreLocation.h>

@implementation UXRYelpRestaurantModel

- (void) setLocation:(id)location {
    if (nil == location) {
        _location = nil;
    }
    else if ([location isKindOfClass:[UXRYelpRestaurantLocationModel class]]) {
        _location = location;
    }
    else if ([location isKindOfClass:[NSDictionary class]]) {
        _location = [[UXRYelpRestaurantLocationModel alloc] initWithDictionary:location];
    }
} 

- (void) setMobile_url:(id)url {
    if (nil == url) {
        _mobile_url = nil;
    }
    else if ([url isKindOfClass:[NSURL class]]) {
        _mobile_url = url;
    }
    else if ([url isKindOfClass:[NSString class]]) {
        _mobile_url = [NSURL URLWithString:url];
    }
}

- (void) setImage_url:(id)url {
    if (nil == url) {
        _image_url = nil;
    }
    else if ([url isKindOfClass:[NSURL class]]) {
        _image_url = url;
    }
    else if ([url isKindOfClass:[NSString class]]) {
        _image_url = [NSURL URLWithString:url];
    }
}

- (void) setUrl:(id)url {
    if (nil == url) {
        _url = nil;
    }
    else if ([url isKindOfClass:[NSURL class]]) {
        _url = url;
    }
    else if ([url isKindOfClass:[NSString class]]) {
        _url = [NSURL URLWithString:url];
    }
}

- (void) setSnippet_image_url:(id)url {
    if (nil == url) {
        _snippet_image_url = nil;
    }
    else if ([url isKindOfClass:[NSURL class]]) {
        _snippet_image_url = url;
    }
    else if ([url isKindOfClass:[NSString class]]) {
        _snippet_image_url = [NSURL URLWithString:url];
    }
}

- (void) setRating_img_url:(id)url {
    if (nil == url) {
        _rating_img_url = nil;
    }
    else if ([url isKindOfClass:[NSURL class]]) {
        _rating_img_url = url;
    }
    else if ([url isKindOfClass:[NSString class]]) {
        _rating_img_url = [NSURL URLWithString:url];
    }
}

- (void) setRating_img_url_large:(id)url {
    if (nil == url) {
        _rating_img_url_large = nil;
    }
    else if ([url isKindOfClass:[NSURL class]]) {
        _rating_img_url_large = url;
    }
    else if ([url isKindOfClass:[NSString class]]) {
        _rating_img_url_large = [NSURL URLWithString:url];
    }
}

- (void) setRating_img_url_small:(id)url {
    if (nil == url) {
        _rating_img_url_small = nil;
    }
    else if ([url isKindOfClass:[NSURL class]]) {
        _rating_img_url_small = url;
    }
    else if ([url isKindOfClass:[NSString class]]) {
        _rating_img_url_small = [NSURL URLWithString:url];
    }
}

- (void) setReviews:(id)reviews {
    if (nil == reviews) {
        _reviews = nil;
    }
    else if ([reviews isKindOfClass:[NSArray class]]) {
        NSArray *reviewsArray = (NSArray*)reviews;
        NSMutableArray *mutableReviews = [[NSMutableArray alloc] initWithCapacity:reviewsArray.count];
        for(id entry in reviewsArray){
            if([entry isKindOfClass:[NSDictionary class]]){
                UXRYelpReviewModel *review = [[UXRYelpReviewModel alloc] initWithDictionary:entry];
                [mutableReviews addObject:review];
            }
        }
        _reviews = (NSArray*)mutableReviews;
    }
}

-(BOOL)isModelValid{
    BOOL isValid = YES;
    
    isValid = self.name != nil;
    isValid = self.url != nil;
    isValid = self.image_url != nil;
    isValid = self.snippet_text != nil;
    isValid = [self.location isModelValid];
    
    return isValid;
}

#pragma mark - UXRBaseRestaurantModel

-(NSURL*)primaryPhotoURL{
    return self.url;
}

-(NSString*)displayName{
    return self.name;
}

-(NSArray*)restaurantPhotosArray{
    [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Yelp does not support this" userInfo:nil];
    return nil;
}

-(CLLocation*)restaurantLocation{
    CLLocationDegrees lat = [self.location.latitude floatValue];
    CLLocationDegrees lon = [self.location.longitude floatValue];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
    return location;
}

-(NSNumber*)priceRating{
    return @3;
}

-(NSNumber*)reviewCountTotal{
    return self.review_count;
}

-(NSString*)readiblePhoneNumber{
    return self.displayName;
}

-(NSString*)primaryRestaurantWebsiteURLPathString{
    return [self.url absoluteString];
}

-(NSString*)readibleAddressString{
    return self.location.display_address[0];
}

-(BOOL)restaurantIsOpenNow{
    return !self.isClosed;
}

-(NSInteger)numberOfReviews{
    return 0;
}

-(NSString*)restaurantIdentifier{
    return self.name;
}

-(NSString*)readibleCityStateString{
    return @"";
}
@end
