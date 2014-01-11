//
//  UXRYelpUserModel.h
//  FMag
//
//  Created by Rex St. John on 12/19/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRBaseModel.h"
#import "UXRBaseUserModel.h"
/*
 
 user =             {
 id = "7jn_OO0hxt1B2LLuLwWx4Q";
 "image_url" = "http://s3-media3.ak.yelpcdn.com/photo/yCyhjWfaT7X0oigxaaXBXw/ms.jpg";
 name = "Megan J.";
 */

@interface UXRYelpUserModel : UXRBaseModel <UXRBaseUserModel>
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSURL *image_url;
@end
