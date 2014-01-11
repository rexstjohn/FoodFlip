//
//  UXRYelpRestaurantModel.h
//  FMag
//
//  Created by Rex St. John on 12/19/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRBaseModel.h"
#import "UXRYelpRestaurantLocationModel.h"
/*
 {
 categories =     (
 (
 Caribbean,
 caribbean
 ),
 (
 Sandwiches,
 sandwiches
 ),
 (
 Cuban,
 cuban
 )
 );
 "display_phone" = "+1-206-545-7440";
 id = "paseo-seattle";
 "image_url" = "http://s3-media3.ak.yelpcdn.com/bphoto/_nKmTEXonPqjqKS4XfRJVA/ms.jpg";
 "is_claimed" = 0;
 "is_closed" = 0;
 location =     {
 address =         (
 "4225 Fremont Ave N"
 );
 city = Seattle;
 coordinate =         {
 latitude = "47.658494";
 longitude = "-122.350312";
 };
 "country_code" = US;
 "cross_streets" = "42nd St & Motor Pl";
 "display_address" =         (
 "4225 Fremont Ave N",
 "(b/t 42nd St & Motor Pl)",
 Fremont,
 "Seattle, WA 98103"
 );
 "geo_accuracy" = 8;
 neighborhoods =         (
 Fremont
 );
 "postal_code" = 98103;
 "state_code" = WA;
 };
 "menu_date_updated" = 1383433726;
 "menu_provider" = "single_platform";
 "mobile_url" = "http://m.yelp.com/biz/paseo-seattle";
 name = Paseo;
 phone = 2065457440;
 rating = "4.5";
 "rating_img_url" = "http://s3-media2.ak.yelpcdn.com/assets/2/www/img/99493c12711e/ico/stars/v1/stars_4_half.png";
 "rating_img_url_large" = "http://s3-media4.ak.yelpcdn.com/assets/2/www/img/9f83790ff7f6/ico/stars/v1/stars_large_4_half.png";
 "rating_img_url_small" = "http://s3-media2.ak.yelpcdn.com/assets/2/www/img/a5221e66bc70/ico/stars/v1/stars_small_4_half.png";
 "review_count" = 2696;
 reviews =     (
 {
 excerpt = "Paseo is definitely a must-eat shop in Seattle. I am from the East coast originally where subs, coldcuts, heros, philly cheesesteaks, etc are all big...";
 id = h0XAIZeKUtvAE3A753eynw;
 rating = 5;
 "rating_image_large_url" = "http://s3-media3.ak.yelpcdn.com/assets/2/www/img/22affc4e6c38/ico/stars/v1/stars_large_5.png";
 "rating_image_small_url" = "http://s3-media1.ak.yelpcdn.com/assets/2/www/img/c7623205d5cd/ico/stars/v1/stars_small_5.png";
 "rating_image_url" = "http://s3-media1.ak.yelpcdn.com/assets/2/www/img/f1def11e4e79/ico/stars/v1/stars_5.png";
 "time_created" = 1387414888;
 user =             {
 id = "YtLeeoRmTALIP6jWD_eGew";
 "image_url" = "http://s3-media3.ak.yelpcdn.com/photo/F1r35VN9At5r1xmUWifZFg/ms.jpg";
 name = "Mike O.";
 };
 },
 {
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
 };
 },
 {
 excerpt = "Yummmm...the sandwiches here are quite tasty! All the sandwiches come with cilantro, jalapenos, grilled onions, and this really yummy aioli on a really...";
 id = "aNR2x8sY27AYeiQwm_0AlQ";
 rating = 4;
 "rating_image_large_url" = "http://s3-media2.ak.yelpcdn.com/assets/2/www/img/ccf2b76faa2c/ico/stars/v1/stars_large_4.png";
 "rating_image_small_url" = "http://s3-media4.ak.yelpcdn.com/assets/2/www/img/f62a5be2f902/ico/stars/v1/stars_small_4.png";
 "rating_image_url" = "http://s3-media4.ak.yelpcdn.com/assets/2/www/img/c2f3dd9799a5/ico/stars/v1/stars_4.png";
 "time_created" = 1387138712;
 user =             {
 id = "_uwuKDqYXnTM2qrpcs3P2w";
 "image_url" = "http://s3-media4.ak.yelpcdn.com/photo/taxOLDIY5ocfo-j5X5mGQg/ms.jpg";
 name = "Sylvia K.";
 };
 }
 );
 "snippet_image_url" = "http://s3-media4.ak.yelpcdn.com/photo/h7lqaeB0SK0t7HQ43H5pBg/ms.jpg";
 "snippet_text" = "I was warned about ridiculously long lines for lunch, and possibly running out of meat. Showed up on a winter Wednesday morning around 1230 and NO LINE. Win...";
 url = "http://www.yelp.com/biz/paseo-seattle";
 }
 */

#import "UXRBaseRestaurantModel.h"

@interface UXRYelpRestaurantModel : UXRBaseModel<UXRBaseRestaurantModel>
@property(nonatomic,strong) NSArray *categories;
@property(nonatomic,strong) NSArray *reviews;
@property(nonatomic,strong) NSString *display_phone;
@property(nonatomic,strong) NSNumber *distance;
@property(nonatomic,strong) NSURL *image_url;
@property(nonatomic,assign) BOOL isClosed;
@property(nonatomic,strong) UXRYelpRestaurantLocationModel *location;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSNumber *phone;
@property(nonatomic,strong) NSNumber *rating;
@property(nonatomic,strong) NSNumber *review_count;
@property(nonatomic,strong) NSString *snippet_text;

@property(nonatomic,strong) NSURL *rating_img_url;
@property(nonatomic,strong) NSURL *rating_img_url_large;
@property(nonatomic,strong) NSURL *rating_img_url_small;
@property(nonatomic,strong) NSURL *mobile_url;
@property(nonatomic,strong) NSURL *url;
@property(nonatomic,strong) NSURL *snippet_image_url;
@end
