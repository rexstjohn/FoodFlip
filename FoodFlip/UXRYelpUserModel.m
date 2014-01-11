//
//  UXRYelpUserModel.m
//  FMag
//
//  Created by Rex St. John on 12/19/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRYelpUserModel.h"

@implementation UXRYelpUserModel

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

#pragma mark - User Protocol

-(NSString*)userDisplayName{
    return self.name;
}

-(NSString*)userDescriptionText{
    return @"";
}

-(id<UXRBasePhotoModel>)userPhoto{
    return nil;
}
@end
