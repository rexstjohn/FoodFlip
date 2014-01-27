//
//  UXRBaseRestaurantTableViewController.h
//  FMag
//
//  Created by Rex St. John on 12/18/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UXRRestaurantHeaderView.h"
#import "UXRSearchDataProvider.h"
#import "UXRImageView.h"
#import "UXRBaseRestaurantModel.h"
#import <HTAutocompleteTextField/HTAutocompleteTextField.h>
#import "GADBannerView.h"

typedef enum{
    UXRPrimaryCellType,
    UXRMapAndDetailsCellType,
    UXRHoursCellType,
    UXRPhotoCarouselCellType,
    UXRAdBannerCellType
}UXRBaseRestaurantTableViewControllerCellType;

typedef enum{
    UXRPrimarySectionType,
    UXRReviewsSectionType
}UXRBaseRestaurantTableViewControllerSectionType;

@protocol UXRBaseRestaurantTableViewControllerDelegate;

@interface UXRBaseRestaurantTableViewController : GAITrackedViewController<UITableViewDataSource,UITableViewDelegate, GADBannerViewDelegate>

@property(nonatomic,strong) IBOutlet UITableView *tableView;
@property(nonatomic,strong) id<UXRBaseRestaurantTableViewControllerDelegate> scrollDelegate;
@property(nonatomic,strong) UXRRestaurantHeaderView *headerView;
@property(nonatomic,strong) id<UXRBaseRestaurantModel> restaurant;
@property(nonatomic,strong) UITapGestureRecognizer *tapGesture;
@property(nonatomic,strong) HTAutocompleteTextField *locationSearchLabel;

// Used to toggle indicators.
@property(nonatomic,assign) BOOL isLastRestaurant;
@property(nonatomic,assign) BOOL isFirstRestaurant;

//
-(void)scrollToTop;

//
-(void)didTapTableView:(UITapGestureRecognizer*)tap;

@end

@protocol UXRBaseRestaurantTableViewControllerDelegate

-(void)embeddedRestaurantScrollViewDidScroll:(UIScrollView*)scrollView;

@end