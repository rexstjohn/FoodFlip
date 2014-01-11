//
//  UXRFourSquareDataManager.m
//  FMag
//
//  Created by Rex St. John on 12/20/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRFourSquareDataManager.h"
#import "UXRSearchDataReciever.h"
#import "UXRFourSquareNetworkingEngine.h"
#import "CLLocation+Testing.h"
#import "UXRGlobals.h"
#import "UXRLocationDataManager.h"

@interface UXRFourSquareDataManager()
@property(nonatomic,strong, readwrite) NSArray *restaurants;
@property(nonatomic,strong) UXRFourSquareNetworkingEngine *fsEngine;
@property(nonatomic,assign) BOOL isWaitingForLocation;
@property(nonatomic,assign) NSInteger selectedIndex;
@property(nonatomic,strong) NSNotification *pausedQueryNotification;

// Default queries
@property(nonatomic,strong) NSString *locationQuery;
@property(nonatomic,strong) NSString *searchQuery;
@property(nonatomic,strong) NSString *pendingSearchQuery;
@end

@implementation UXRFourSquareDataManager

- (id) init {
    static BOOL alreadyInitialized = NO;
    if (alreadyInitialized) {
        return self;
    }
    alreadyInitialized = YES;
    
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(triggerUpdate:)
                                                     name:REQUEST_RESTAURANT_DATA_UPDATE_NOTIFICATION object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(searchBarDidSearch:)
                                                     name:SEARCH_BAR_DID_SEARCH_NOTIFICATION object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loactionSearchDidUpdate:) name:LOCATION_SEARCH_DID_END_EDITING_NOTIFICATION
                                                   object:nil];
        
        // Location checkers
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleLocationUpdate:) name:LOCATION_FOUND object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleLocationError:) name:LOCATION_FOUND_ERROR object:nil];
        
        self.fsEngine = [[UXRFourSquareNetworkingEngine alloc] init];
        self.restaurants = [NSArray array];
        self.selectedIndex = 0;
        self.locationQuery = @"nearby";
        self.searchQuery = self.pendingSearchQuery = @"";
    }
    return self;
}

#pragma mark - Single Getters

-(void)getFullRestaurantWithId:(NSString*)restaurantId
                                          completion:(RestaurantCompletionBlock)completion
                                               error:(ErrorBlock)error{
    // Used when fetching a full restaurant when it is actually time to display
    NSString *restaurantIdCopy = restaurantId;
    
    [self.fsEngine getRestaurantWithId:restaurantIdCopy
                   withCompletionBlock:^(UXRFourSquareRestaurantModel *restaurant) { 
                       if([restaurantIdCopy isEqualToString:restaurant.restaurantId] == YES){
                           completion(restaurant);
                       }
                   } failureBlock:^(NSError *errorResult) {
                       error(errorResult);
                   }];
}

#pragma mark - Setters

-(NSInteger)getSelectedRestaurantIndex{
    return self.selectedIndex;
}

-(void)setSelectedRestaurantIndex:(NSInteger)index{
    _selectedIndex = index;
}

#pragma mark - Data Provider Delegate Methods

+(id<UXRSearchDataProvider>) sharedManager; {
    static dispatch_once_t onceQueue;
    static UXRFourSquareDataManager* _sharedInstance;
    dispatch_once(&onceQueue, ^{ _sharedInstance = [[self alloc] init]; });
    return _sharedInstance;
}

-(void)triggerUpdate:(NSNotification*)notification{
    
    // We have finished updating.
    NSNotification *beginUpdateNotification = [NSNotification
                                               notificationWithName:RESTAURANT_DATA_UPDATES_BEGIN_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:beginUpdateNotification];
    
    // What type of query is this? Nearby or Location String.
    NSString *locationString = [self.locationQuery lowercaseString];
    NSString *queryString = self.pendingSearchQuery;
    CLLocation *location = [[UXRLocationDataManager sharedManager] lastTrackedLocation];
    
    if(location == nil){
        self.isWaitingForLocation = YES;
        self.pausedQueryNotification = notification;
        return;
    }
    
    // If location string is not "nearby", use actual lat / long
    if([locationString isEqualToString:@"nearby"] == YES){ 
        [self.fsEngine exploreRestaurantsNearLatLong:location.coordinate
                                           withQuery:queryString withCompletionBlock:^(NSArray *restaurants) {
                                               self.selectedIndex = 0;
                                               if(restaurants.count == 0){
                                                   [self onUpdateFailed];
                                               } else {
                                                   self.searchQuery = self.pendingSearchQuery;
                                                   self.restaurants = restaurants;
                                                   [self onResultsDidUpdate];
                                               }
                                         
        } failureBlock:^(NSError *error) {
            [self onUpdateFailed];
        }];
    } else {
        [self.fsEngine exploreRestaurantsNearLocation:locationString
                                            withQuery:queryString
                                  withCompletionBlock:^(NSArray *restaurants) {
                                      self.selectedIndex = 0;
            self.searchQuery = self.pendingSearchQuery;
            self.restaurants = restaurants;
            [self onResultsDidUpdate];
        } failureBlock:^(NSError *error) {
            [self onUpdateFailed];
        }];
    }
}

-(void)onResultsDidUpdate{
    NSNotification *notification = [NSNotification
                                    notificationWithName:RESTAURANT_DATA_UPDATED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
 
-(void)onUpdateFailed{
    NSNotification *notification = [NSNotification
                                    notificationWithName:RESTAURANT_DATA_UPDATE_FAILURE_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

#pragma mark - Search behaviors

-(void)loactionSearchDidUpdate:(NSNotification*)notification{
    NSDictionary *userInfo = notification.userInfo;
    NSString *query = [userInfo valueForKey:SEARCH_BAR_USER_INFO_QUERY_KEY];
    
    if([self.locationQuery isEqualToString:query] == NO){
        self.locationQuery = query;
        [self triggerUpdate:nil];
    }
}

-(void)searchBarDidSearch:(NSNotification*)notification{
    NSDictionary *userInfo = notification.userInfo;
    NSString *query = [userInfo valueForKey:SEARCH_BAR_USER_INFO_QUERY_KEY];
    
    if([self.searchQuery isEqualToString:query] == NO){
        self.pendingSearchQuery = query;
        [self triggerUpdate:nil];
    }
}

-(NSArray*)getResponseResults{
    return self.restaurants;
}

-(NSString*)getLocationString{
    return self.locationQuery;
}

-(NSString*)getQueryString{
    return self.searchQuery;
}
    
#pragma mark - Location errors
    
-(void)handleLocationUpdate:(NSNotification*)notification{
    
    if(self.isWaitingForLocation == YES){
        self.isWaitingForLocation = NO;
        [self triggerUpdate:self.pausedQueryNotification];
    }
}
    
-(void)handleLocationError:(NSNotification*)notification{
    
}
    
@end
