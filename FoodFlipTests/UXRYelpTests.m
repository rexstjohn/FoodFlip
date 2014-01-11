//
//  UXROAUTHTests.m
//  FMag
//
//  Created by Rex St. John on 12/15/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UXRYelpNetworkingEngine.h"
#import "UXRAsyncTesting.h"
#import "CLLocation+Testing.h"
#import "UXRYelpRestaurantModel.h"

@interface UXRYelpTests : XCTestCase
@property(nonatomic,strong) UXRYelpNetworkingEngine *yelpEngine;
@end

@implementation UXRYelpTests

- (void)setUp
{
    [super setUp];
    self.yelpEngine = [UXRYelpNetworkingEngine sharedInstance];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testSFRestaurants
{
    StartBlock(); 
    
    [self.yelpEngine getRestaurantsWithCompletionBlock:^(NSArray *restaurants) {
        XCTAssert(restaurants.count != 0, @"Results should not be empty");
        UXRYelpRestaurantModel *restaurantModel = (UXRYelpRestaurantModel *)[restaurants objectAtIndex:0];
        BOOL isValid = [restaurantModel isModelValid];
        XCTAssertEqual(isValid, YES, @"Model was not valid");
        EndBlock();
    } failureBlock:^(NSError *error) {
        XCTAssertNil(error, @"Error should be nil");
        EndBlock();
    }];
    WaitUntilBlockCompletes();
    
}

- (void)testLocationalRestaurants
{
    StartBlock();
    
    CLLocation *location = [CLLocation locationInSeattle];
    
    [self.yelpEngine getRestaurantsNearLocation:location withCompletionBlock:^(NSArray *restaurants) {
        XCTAssert(restaurants.count != 0, @"Results should not be empty");
        UXRYelpRestaurantModel *restaurantModel = (UXRYelpRestaurantModel *)[restaurants objectAtIndex:0];
        BOOL isValid = [restaurantModel isModelValid];
        XCTAssertEqual(isValid, YES, @"Model was not valid");
        EndBlock();
    } failureBlock:^(NSError *error) {
        XCTAssertNil(error, @"Error should be nil");
        EndBlock();
    }];
    
    WaitUntilBlockCompletes();
}

- (void)testGetBusiness
{
    StartBlock();
    
    NSString *businessId = @"paseo-seattle";
    [self.yelpEngine getRestaurantById:businessId withCompletionBlock:^(UXRYelpRestaurantModel *restaurantModel) {
        BOOL isValid = [restaurantModel isModelValid];
        XCTAssertEqual(isValid, YES, @"Model was not valid");
        EndBlock();
    } failureBlock:^(NSError *error) {
        XCTAssertNil(error, @"Error should be nil");
        EndBlock();
    }];
    
    WaitUntilBlockCompletes();
}

@end
