

#import "RSOAuthEngine.h"
#import <CoreLocation/CoreLocation.h>
#import "UXRYelpRestaurantModel.h"

typedef void (^UXRYelpEngineCompletionBlock)(NSArray *restaurants);
typedef void (^UXRYelpEngineBusinessCompletionBlock)(UXRYelpRestaurantModel *restaurant);
typedef void (^UXRYelpEngineErrorBlock)(NSError *error);

@interface UXRYelpNetworkingEngine : RSOAuthEngine
{}

+(UXRYelpNetworkingEngine*) sharedInstance;

- (void)getRestaurantsWithCompletionBlock:(UXRYelpEngineCompletionBlock)completionBlock
                             failureBlock:(UXRYelpEngineErrorBlock)errorBlock;

- (void)getRestaurantsNearLocation:(CLLocation*)location withCompletionBlock:(UXRYelpEngineCompletionBlock)completionBlock
                               failureBlock:(UXRYelpEngineErrorBlock)errorBlock;

- (void)getRestaurantById:(NSString*)restaurantId
      withCompletionBlock:(UXRYelpEngineBusinessCompletionBlock)completionBlock
             failureBlock:(UXRYelpEngineErrorBlock)errorBlock;

@end