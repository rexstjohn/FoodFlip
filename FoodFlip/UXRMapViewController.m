//
//  UXRMapViewController.m
//  FMag
//
//  Created by Rex St. John on 12/18/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRMapViewController.h"
#import "UXRLocationDataManager.h"
#import "MKMapView+Zooming.h"
#import "UXRSearchDataReciever.h"
#import "UXRRestaurantMapAnnotation.h"
#import "UXRBaseRestaurantModel.h"
#import "UXRFourSquareDataManager.h"
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD.h"

@interface UXRMapViewController ()
@property(nonatomic,strong) NSArray *restaurants;
@property(nonatomic,strong) id<UXRBaseRestaurantModel> selectedRestaurant;
@property(nonatomic,strong) id<UXRSearchDataProvider> provider;
@end

@implementation UXRMapViewController

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Custom initialization
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
    
    self.provider = (id<UXRSearchDataProvider>)[UXRFourSquareDataManager sharedManager];
    self.restaurants =[self.provider getResponseResults];
    self.mapView.delegate = self;
    
    if(self.restaurants.count == 0){
        CLLocation *location = [[UXRLocationDataManager sharedManager] lastTrackedLocation];
        [self.mapView zoomToLocation:location withMarginInMiles:1.0f animated:NO];
    } else{
        
    }
}
    
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.screenName = @"Map View Screen";
}

#pragma mark - UXRSearchDataReciever Methods

-(void)restaurantDataDidBeginUpdates:(NSNotification*)notification{
    // Show loader
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    });
}

-(void)restaurantDataDidUpdate:(NSNotification*)notification{
    // Hide loader.
    __weak UXRMapViewController *weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.restaurants = [self.provider  getResponseResults];
        [self.mapView zoomToFitAnnotationsAnimated:NO];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    });
}

-(void)restaurantDataUpdateDidFailWithError:(NSNotification*)notification{
    // Hide loader;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    //
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
}

#pragma mark - Setters

-(void)setRestaurants:(NSArray *)restaurants{
    _restaurants = restaurants;
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    for(id<UXRBaseRestaurantModel> model in _restaurants){
        UXRRestaurantMapAnnotation *annotation = [[UXRRestaurantMapAnnotation alloc] init];
        CLLocation *location = [model restaurantLocation];
        annotation.coordinate = location.coordinate;
        annotation.title = [model displayName];
        [self.mapView addAnnotation:annotation];
    }
    [self.mapView zoomToFitAnnotationsAnimated:NO];
}

@end
