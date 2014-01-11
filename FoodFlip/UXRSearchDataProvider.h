//
//  UXRSearchDataProvider.h
//  FMag
//
//  Created by Rex St. John on 12/20/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UXRBaseRestaurantModel.h"
#import "UXRLocationDataManager.h"

typedef void (^RestaurantCompletionBlock)(id<UXRBaseRestaurantModel> restaurant);
typedef void (^ErrorBlock)(NSError *error);

@protocol UXRSearchDataProvider <UXRLocationDataManagerDelegate>

+(id<UXRSearchDataProvider>) sharedManager;
-(void)triggerUpdate:(NSNotification*)notification;
-(void)onResultsDidUpdate;
-(void)onUpdateFailed;
-(void)searchBarDidSearch:(NSNotification*)notification;
-(NSArray*)getResponseResults;
-(NSInteger)getSelectedRestaurantIndex;
-(void)setSelectedRestaurantIndex:(NSInteger)index;
-(NSString*)getLocationString;
-(NSString*)getQueryString;

// Single Getters.
@optional
-(void)getFullRestaurantWithId:(NSString*)restaurantId
                    completion:(RestaurantCompletionBlock)completion
                         error:(ErrorBlock)error;

@end
