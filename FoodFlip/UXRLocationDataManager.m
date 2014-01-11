
#import "UXRLocationDataManager.h"

@interface UXRLocationDataManager()
@property (strong, nonatomic) CLLocationManager *locationManager;
@property(nonatomic,strong,readwrite) CLLocation *lastTrackedLocation;
@end

@implementation UXRLocationDataManager

#pragma mark - initialization

- (id) init {
    static BOOL alreadyInitialized = NO;
    if (alreadyInitialized) {
        return self;
    }
    alreadyInitialized = YES;
    
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        [self startLocationServices];
    }
    return self;
}

+(UXRLocationDataManager*) sharedManager; {
    static dispatch_once_t onceQueue;
    static UXRLocationDataManager* _sharedInstance;
    dispatch_once(&onceQueue, ^{ _sharedInstance = [[self alloc] init]; });
    return _sharedInstance;
}

-(void)startLocationServices {
    [self.locationManager startMonitoringSignificantLocationChanges];
    [self.locationManager startUpdatingLocation];
}

#pragma mark - properties

- (BOOL)isLocationServiceDisabled {
    BOOL value = ![self canUseLocationServices];
    return value;
}

#pragma mark - private helper methods

- (BOOL) canUseLocationServices {
    BOOL value = NO;
    BOOL locationServicesIsAuthorized = [CLLocationManager locationServicesEnabled];
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    BOOL thisAppIsAuthorized = (kCLAuthorizationStatusAuthorized == authorizationStatus);
    value = locationServicesIsAuthorized && thisAppIsAuthorized;
    return value;
}

#pragma mark - CLLocation Manager Delegate Methods.


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    // this saves battery power. we will still be notified of significant location changes.
    [self.locationManager stopUpdatingLocation];
    
    id lastLocation = [locations lastObject];
    if (nil == lastLocation) {
        return;
    }
    
    self.lastTrackedLocation = lastLocation;
    NSNotification *notification = [NSNotification notificationWithName:LOCATION_FOUND object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSInteger errorCode = error.code;
    switch (errorCode) {
        case kCLErrorLocationUnknown:
        {
            break;
        }
        case kCLErrorDenied:
        {
            break;
        }
        case kCLErrorNetwork:
        {
            break;
        }
        default:
            break;
    }
    
    NSNotification *notification = [NSNotification notificationWithName:LOCATION_FOUND_ERROR object:error];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
