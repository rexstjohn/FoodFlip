//
//  UXRFourSquareUserModel.m
//  FMag
//
//  Created by Rex St. John on 12/20/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRFourSquareUserModel.h"
#import "UXRFourSquarePhotoModel.h"

@implementation UXRFourSquareUserModel

- (void) setPhoto:(id)photo {
    if (nil == photo) {
        _photo = nil;
    }
    else if ([photo isKindOfClass:[UXRFourSquarePhotoModel class]]) {
        _photo = photo;
    }
    else if ([photo isKindOfClass:[NSDictionary class]]) {
        _photo = [[UXRFourSquarePhotoModel alloc] initWithDictionary:photo];
    }
}

#pragma mark - User Protocol

-(NSString*)userDisplayName{
    NSString *first = (self.firstName != nil)?self.firstName:@"";
    NSString *last = (self.lastName != nil)?self.lastName:@"";
    return [NSString stringWithFormat:@"%@ %@", first, last];
}

-(id<UXRBasePhotoModel>)userPhoto{
    return self.photo;
}

-(NSString*)userDescriptionText{
    return @"";
}

@end
