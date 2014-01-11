//
//  UXRAppDelegate.m
//  FMag
//
//  Created by Rex St. John on 12/15/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRAppDelegate.h"  
#import "UXRLocationDataManager.h"
#import "UXRGlobals.h"
#import "TestFlight.h"
#import "UXRSearchDataProviderLocator.h"
#import "UXRFourSquareDataManager.h"

@interface UXRAppDelegate()
@end

@implementation UXRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Bootstrap locations.
    [UXRLocationDataManager sharedManager];
     [TestFlight takeOff:TESTFLIGHT_KEY];
    [[UXRSearchDataProviderLocator sharedManager] setProvider:[UXRFourSquareDataManager sharedManager]];
    [self initializeApplicationTracking];
    return YES;
}

-(void)initializeApplicationTracking{
    // https://developers.google.com/analytics/devguides/collection/ios/v2/#initialize
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;
    [[GAI sharedInstance] trackerWithTrackingId:GOOGLE_ANALYTICS_KEY];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
