//
//  UXRBaseNavigationViewController.m
//  FMag
//
//  Created by Rex St. John on 12/31/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRBaseNavigationViewController.h"
#import "MPFlipSegue.h"
#import "UXRSearchDataReciever.h"
#import "UXRGlobals.h" 

@interface UXRBaseNavigationViewController ()

@end

@implementation UXRBaseNavigationViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(restaurantDataDidBeginUpdates:)
                                                 name:RESTAURANT_DATA_UPDATES_BEGIN_NOTIFICATION
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(restaurantDataDidUpdate:)
                                                 name:RESTAURANT_DATA_UPDATED_NOTIFICATION
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(restaurantDataUpdateDidFailWithError:)
                                                 name:RESTAURANT_DATA_UPDATE_FAILURE_NOTIFICATION
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(queryDidChange:)
                                                 name:SEARCH_BAR_DID_SEARCH_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(locationDidChange:)
                                                 name:LOCATION_SEARCH_DID_END_EDITING_NOTIFICATION
                                               object:nil];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Custom Segues

// We need to over-ride this method from UIViewController to provide a custom segue for unwinding
- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier{
    
    return [super segueForUnwindingToViewController:toViewController fromViewController:fromViewController identifier:identifier];
}


#pragma mark - UXRSearchDataReciever Methods

-(void)restaurantDataDidBeginUpdates:(NSNotification*)notification{
    // Show loader
}

-(void)restaurantDataDidUpdate:(NSNotification*)notification{
    [self popToRootViewControllerAnimated:YES];
}

-(void)restaurantDataUpdateDidFailWithError:(NSNotification*)notification{
}

#pragma mark - Handle Location Changes

-(void)queryDidChange:(NSNotification*)notification{ 
}

#pragma mark - Handle Search Query Changes

-(void)locationDidChange:(NSNotification*)notification{
}

@end
