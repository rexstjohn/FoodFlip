//
//  UXRYelpReviewModel.m
//  FMag
//
//  Created by Rex St. John on 12/19/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRYelpReviewModel.h"

@implementation UXRYelpReviewModel
 

- (void) setRating_img_url:(id)url {
    if (nil == url) {
        _rating_image_url = nil;
    }
    else if ([url isKindOfClass:[NSURL class]]) {
        _rating_image_url = url;
    }
    else if ([url isKindOfClass:[NSString class]]) {
        _rating_image_url = [NSURL URLWithString:url];
    }
}

- (void) setRating_img_large_url:(id)url {
    if (nil == url) {
        _rating_image_large_url = nil;
    }
    else if ([url isKindOfClass:[NSURL class]]) {
        _rating_image_large_url = url;
    }
    else if ([url isKindOfClass:[NSString class]]) {
        _rating_image_large_url = [NSURL URLWithString:url];
    }
}

- (void) setRating_img_small_url:(id)url {
    if (nil == url) {
        _rating_image_small_url = nil;
    }
    else if ([url isKindOfClass:[NSURL class]]) {
        _rating_image_small_url = url;
    }
    else if ([url isKindOfClass:[NSString class]]) {
        _rating_image_small_url = [NSURL URLWithString:url];
    }
}

- (void) setUser:(id)user {
    if (nil == user) {
        _user = nil;
    }
    else if ([user isKindOfClass:[UXRYelpUserModel class]]) {
        _user = user;
    }
    else if ([user isKindOfClass:[NSDictionary class]]) {
        _user = [[UXRYelpUserModel alloc] initWithDictionary:user];
    }
}

#pragma mark - Review Model Protocol

-(NSString*)reviewBodyText{
    return @"";
}

-(NSString*)reviewTitleText{
    return @"";
}

-(id<UXRBaseUserModel>)reviewUserAuthor{
    return nil;
}

@end
