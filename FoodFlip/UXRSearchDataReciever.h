//
//  UXRSearchDataReciever.h
//  FMag
//
//  Created by Rex St. John on 12/19/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RESTAURANT_DATA_UPDATES_BEGIN_NOTIFICATION @"RESTAURANT_DATA_UPDATES_BEGIN_NOTIFICATION"
#define RESTAURANT_DATA_UPDATED_NOTIFICATION @"RESTAURANT_DATA_UPDATED_NOTIFICATION"
#define RESTAURANT_DATA_PROGRESS_NOTIFICATION @"RESTAURANT_DATA_PROGRESS_NOTIFICATION"
#define RESTAURANT_DATA_UPDATE_FAILURE_NOTIFICATION @"RESTAURANT_DATA_UPDATE_FAILURE_NOTIFICATION"
#define REQUEST_RESTAURANT_DATA_UPDATE_NOTIFICATION @"REQUEST_RESTAURANT_DATA_UPDATE_NOTIFICATION"

@protocol UXRSearchDataReciever
-(void)restaurantDataDidBeginUpdates:(NSNotification*)notification;
-(void)restaurantDataDidUpdate:(NSNotification*)notification;
-(void)restaurantDataUpdateDidFailWithError:(NSNotification*)notification;
@end
