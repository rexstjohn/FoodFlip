
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define LOCATION_FOUND @"LOCATION_FOUND"
#define LOCATION_FOUND_ERROR @"LOCATION_FOUND_ERROR"

@protocol UXRLocationDataManagerDelegate;

@interface UXRLocationDataManager:NSObject <CLLocationManagerDelegate>

+(UXRLocationDataManager*) sharedManager;
@property(nonatomic,strong,readonly) CLLocation *lastTrackedLocation;
    
@end

@protocol UXRLocationDataManagerDelegate
    
-(void)handleLocationUpdate:(NSNotification*)notification;
-(void)handleLocationError:(NSNotification*)notification;
    
@end
