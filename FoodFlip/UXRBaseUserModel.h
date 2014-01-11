//
//  UXRBaseUserModel.h
//  FMag
//
//  Created by Rex St. John on 12/23/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UXRBasePhotoModel.h"

@protocol UXRBaseUserModel
-(NSString*)userDisplayName;
-(NSString*)userDescriptionText;
-(id<UXRBasePhotoModel>)userPhoto;
@end
