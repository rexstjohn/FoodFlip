//
//  UXRGlobals.h
//  FMag
//
//  Created by Rex St. John on 12/20/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UXRGlobals : NSObject
extern NSString* FOURSQUARE_CLIENT_ID;
extern NSString* FOURSQUARE_SECRET;
extern NSString* FOURSQUARE_CALLBACK_URL;

//Storyboard keys
extern NSString* MAIN_STORYBOARD_ID;

// Notifications
extern NSString* SEARCH_BAR_DID_SEARCH_NOTIFICATION;
extern NSString* SEARCH_BAR_USER_INFO_QUERY_KEY;
extern NSString* LOCATION_SEARCH_DID_END_EDITING_NOTIFICATION;
extern NSString* FILTER_BUTTON_REQUESTED_OPEN_NOTIFICATION;
extern NSString* MAP_BUTTON_REQUESTED_OPEN_NOTIFICATION;
extern NSString* PHOTO_WAS_SELECTED_NOTIFICATION;
extern NSString* LOAD_URL_REQUEST_NOTIFICATION;
extern NSString* SHARE_REQUEST_NOTIFICATION;


//
extern NSString* CONNECTIVITY_ISSUE_NOTIFICATION;
extern NSString* LOCATION_ISSUE_NOTIFICATION;

//
extern NSString* NOPHOTO_IMAGE_PATH;
extern NSString* BACKGROUND_IMAGE_PHOTO_PATH;

//
extern NSString* USER_INFO_WEBSITE_URL_KEY;

// Advertising & tracking
extern NSString* ADMOB_ADVERTISING_KEY;
extern NSString * TESTFLIGHT_KEY;
extern NSString * GOOGLE_ANALYTICS_KEY;

@end
