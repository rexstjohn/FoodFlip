

#import "UXRYelpNetworkingEngine.h"
#import "UXRLocationDataManager.h"
#import "UXRYelpRestaurantModel.h"

// Never share this information
static const NSString* YELP_CONSUMER_KEY =@"_43tnDGXeC68MWxsmvjitg";
static const NSString* YELP_CONSUMER_SECRET =@"mhuTrvZ6iRQZeza0NwM3pCB6lZk";
static const NSString* YELP_TOKEN =@"aY8ymWRZeo2ek3Tj1jKeMB_i4l__6HTW";
static const NSString* YELP_TOKEN_SECRET =@"76utCRfqCUGkIXZLHnmNsVtp8I4";

// Default twitter hostname and paths
static const NSString* YELP_HOSTNAME =@"api.yelp.com";
static const NSString* YELP_API =@"v2";

//
static const NSString*  YELP_SEARCH_PATH = @"search";
static const NSString*  YELP_BUSINESS_PATH = @"business";

@interface UXRYelpNetworkingEngine ()
@end

@implementation UXRYelpNetworkingEngine

#pragma mark - Initialization

- (id) init {
    static BOOL alreadyInitialized = NO;
    if (alreadyInitialized) {
        return self;
    }
    alreadyInitialized = YES;
    
    NSString *hostPath = [NSString stringWithFormat:@"%@/%@", YELP_HOSTNAME, YELP_API];
    self = [super initWithHostName:hostPath
                customHeaderFields:nil
                   signatureMethod:RSOAuthHMAC_SHA1
                       consumerKey:[YELP_CONSUMER_KEY copy]
                    consumerSecret:[YELP_CONSUMER_SECRET copy]
                       callbackURL:nil];
    [self useCache];
    [self setAccessToken:[YELP_TOKEN copy] secret:[YELP_TOKEN_SECRET copy]];
    if (self) {
    }
    return self;
}

+(UXRYelpNetworkingEngine*) sharedInstance; {
    static dispatch_once_t onceQueue;
    static UXRYelpNetworkingEngine* _sharedInstance;
    dispatch_once(&onceQueue, ^{ _sharedInstance = [[self alloc] init]; });
    return _sharedInstance;
}

#pragma mark - Rendering models

-(NSArray*)renderJSONToYelpRestaurantModels:(NSArray*)models{
    
    NSMutableArray *yelpModels = [[NSMutableArray alloc] initWithCapacity:models.count];
    
    for(NSDictionary *business in models){
        UXRYelpRestaurantModel *restaurantModel = [[UXRYelpRestaurantModel alloc] initWithDictionary:business];
        [yelpModels addObject:restaurantModel];
    }
    
    return (NSArray*)yelpModels;
}

#pragma mark - Public Methods

- (void)getRestaurantsWithCompletionBlock:(UXRYelpEngineCompletionBlock)completionBlock
     failureBlock:(UXRYelpEngineErrorBlock)errorBlock
{
    
    // Fill the post body with the tweet
    NSMutableDictionary *postParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"food", @"type",
                                       @"San Francisco", @"location",
                                       nil];
    
    MKNetworkOperation *op = [self operationWithPath:[YELP_SEARCH_PATH copy]
                                              params:postParams
                                          httpMethod:@"GET"
                                                 ssl:NO];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSError* error = nil;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:[completedOperation responseData]
                              options:kNilOptions
                              error:&error];
        if(error != nil){
            errorBlock(error);
        }
        NSArray* businesses = json[@"businesses"];
        completionBlock([self renderJSONToYelpRestaurantModels:businesses]);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    
    [self enqueueSignedOperation:op];    
}

- (void)getRestaurantsNearLocation:(CLLocation*)location
               withCompletionBlock:(UXRYelpEngineCompletionBlock)completionBlock
                      failureBlock:(UXRYelpEngineErrorBlock)errorBlock{
    
    NSString *latLonString = [NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude];
    
    // Fill the post body with the tweet
    NSMutableDictionary *postParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"food", @"type",
                                       latLonString,@"ll",
                                       nil];
    
    MKNetworkOperation *op = [self operationWithPath:[YELP_SEARCH_PATH copy]
                                              params:postParams
                                          httpMethod:@"GET"
                                                 ssl:NO];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSError* error = nil;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:[completedOperation responseData]
                              options:kNilOptions
                              error:&error];
        if(error != nil){
            errorBlock(error);
        }
        
        NSArray* businesses = json[@"businesses"];
        
        completionBlock([self renderJSONToYelpRestaurantModels:businesses]);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    
    [self enqueueSignedOperation:op];
    
}

- (void)getRestaurantById:(NSString*)restaurantId
      withCompletionBlock:(UXRYelpEngineBusinessCompletionBlock)completionBlock
             failureBlock:(UXRYelpEngineErrorBlock)errorBlock;{
    
    // Fill the post body with the tweet
    NSString *businessPath = [NSString stringWithFormat:@"%@/%@", YELP_BUSINESS_PATH, restaurantId];
    
    MKNetworkOperation *op = [self operationWithPath:businessPath
                                              params:nil
                                          httpMethod:@"GET"
                                                 ssl:NO];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSError* error = nil;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:[completedOperation responseData]
                              options:kNilOptions
                              error:&error];
        if(error != nil){
            errorBlock(error);
        }
         
        UXRYelpRestaurantModel *restaurant = [[UXRYelpRestaurantModel alloc] initWithDictionary:json];
        completionBlock(restaurant);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    
    [self enqueueSignedOperation:op];
}

@end
