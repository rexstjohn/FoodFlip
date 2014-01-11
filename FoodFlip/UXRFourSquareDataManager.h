//
//  UXRFourSquareDataManager.h
//  FMag
//
//  Created by Rex St. John on 12/20/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRSearchDataProvider.h"
#import "UXRLocationDataManager.h"

@interface UXRFourSquareDataManager : NSObject <UXRSearchDataProvider, UXRLocationDataManagerDelegate>

+(id<UXRSearchDataProvider>) sharedManager;
-(void)triggerUpdate:(NSNotification*)notification;
-(void)onResultsDidUpdate;
-(void)onUpdateFailed;
-(NSInteger)getSelectedRestaurantIndex;
-(void)setSelectedRestaurantIndex:(NSInteger)index;

//
-(void)getFullRestaurantWithId:(NSString*)restaurantId
                    completion:(RestaurantCompletionBlock)completion
                         error:(ErrorBlock)error;

//
-(NSString*)getLocationString;
-(NSString*)getQueryString;

@end
