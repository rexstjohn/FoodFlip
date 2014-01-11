//
//  UXRYelpDataManager.m
//  FMag
//
//  Created by Rex St. John on 12/20/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRYelpDataManager.h"
#import "UXRSearchDataReciever.h"
#import "UXRYelpNetworkingEngine.h"
#import "CLLocation+Testing.h"
#import "UXRGlobals.h"

@interface UXRYelpDataManager()
@property(nonatomic,strong, readwrite) NSArray *restaurants;
@property(nonatomic,strong) UXRYelpNetworkingEngine *yelpEngine;
@property(nonatomic,strong) NSString *searchQuery;
@end

@implementation UXRYelpDataManager

- (id) init {
    static BOOL alreadyInitialized = NO;
    if (alreadyInitialized) {
        return self;
    }
    alreadyInitialized = YES;
    
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(triggerUpdate:) name:REQUEST_RESTAURANT_DATA_UPDATE_NOTIFICATION object:nil];
        self.yelpEngine = [UXRYelpNetworkingEngine sharedInstance];
        self.restaurants = [NSArray array];
        
        
        // Location checkers
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLocationUpdate:) name:LOCATION_FOUND object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLocationError:) name:LOCATION_FOUND_ERROR object:nil];
    }
    return self;
}

#pragma mark - Data Provider Delegate Methods

+(id<UXRSearchDataProvider>) sharedManager;{
    static dispatch_once_t onceQueue;
    static UXRYelpDataManager* _sharedInstance;
    dispatch_once(&onceQueue, ^{ _sharedInstance = [[self alloc] init]; });
    return _sharedInstance;
}


-(void)triggerUpdate:(NSNotification*)notification{
    // NSDictionary *userData = notification.userInfo;
    
    NSNotification *beginUpdateNotification = [NSNotification
                                               notificationWithName:RESTAURANT_DATA_UPDATES_BEGIN_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:beginUpdateNotification];
    
    CLLocation *location = [CLLocation locationInSeattle];
    [self.yelpEngine getRestaurantsNearLocation:location
                            withCompletionBlock:^(NSArray *restaurants) {
                                self.restaurants = restaurants;
                                [self onResultsDidUpdate];
                            } failureBlock:^(NSError *error) {
                                [self onUpdateFailed];
                            }];
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


-(void)searchBarDidSearch:(NSNotification*)notification{
    NSDictionary *userInfo = notification.userInfo;
    NSString *query = [userInfo valueForKey:SEARCH_BAR_USER_INFO_QUERY_KEY];
    self.searchQuery = query;
}

-(NSArray*)getResponseResults{
    return self.restaurants;
}

-(NSInteger)getSelectedRestaurantIndex{return 0;} 
-(NSString*)getLocationString{return @"";}
-(void)setSelectedRestaurantIndex:(NSInteger)index{}
-(NSString*)getQueryString{return @"";}
    
#pragma mark - Location errors
    
-(void)handleLocationUpdate:(NSNotification*)notification{
}
    
-(void)handleLocationError:(NSNotification*)notification{
    
}
@end
