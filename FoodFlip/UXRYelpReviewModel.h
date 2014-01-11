//
//  UXRYelpReviewModel.h
//  FMag
//
//  Created by Rex St. John on 12/19/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

/*
 excerpt = "I don't exactly get the hype. Maybe Cuban isn't my thing? Maybe a sandwich the size of my face isn't my thing? Maybe half meat half fat reallyyyy isn't my...";
 id = cZnioJwW1iS8xoCm1A0Ncw;
 rating = 3;
 "rating_image_large_url" = "http://s3-media1.ak.yelpcdn.com/assets/2/www/img/e8b5b79d37ed/ico/stars/v1/stars_large_3.png";
 "rating_image_small_url" = "http://s3-media3.ak.yelpcdn.com/assets/2/www/img/902abeed0983/ico/stars/v1/stars_small_3.png";
 "rating_image_url" = "http://s3-media3.ak.yelpcdn.com/assets/2/www/img/34bc8086841c/ico/stars/v1/stars_3.png";
 "time_created" = 1387153813;
 user =             {
 id = "7jn_OO0hxt1B2LLuLwWx4Q";
 "image_url" = "http://s3-media3.ak.yelpcdn.com/photo/yCyhjWfaT7X0oigxaaXBXw/ms.jpg";
 name = "Megan J.";
 */

#import "UXRBaseModel.h"
#import "UXRYelpUserModel.h"
#import "UXRBaseReviewModel.h"

@interface UXRYelpReviewModel : UXRBaseModel<UXRBaseReviewModel>
@property(nonatomic,strong) NSString *excerpt;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSNumber *rating;
@property(nonatomic,strong) NSNumber *time_created;

@property(nonatomic,strong) UXRYelpUserModel *user;

@property(nonatomic,strong) NSURL *rating_image_large_url;
@property(nonatomic,strong) NSURL *rating_image_small_url;
@property(nonatomic,strong) NSURL *rating_image_url;
@end
