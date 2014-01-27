//
//  UXRBaseRestaurantTableViewController.m
//  FMag
//
//  Created by Rex St. John on 12/18/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRBaseRestaurantTableViewController.h"
#import "UXRRestaurantHeaderView.h"
#import "UXRLocationDataManager.h"
#import "MKMapView+Zooming.h"
#import "UXRBasePhotoModel.h"
#import "UXRRestaurantMapAnnotation.h"
#import "UXRGlobals.h"
#import "UXRPhotoCarouselTableViewCell.h"
#import "UXRRestaurantHoursTableViewCell.h"
#import "UXRRestaurantReviewTableViewCell.h"
#import "UXRRestaurantPrimaryTableViewCell.h"
#import "UXRRestaurantMapAndDetailsTableViewCell.h"
#import "UXRRestaurantMapAndDetailsTableViewCell+Binding.h"
#import "UXRRestaurantPrimaryTableViewCell+Binding.h"
#import "UXRPhotoCarouselTableViewCell+Binding.h"
#import "UXRRestaurantHoursTableViewCell+Binding.h"
#import "UXRBaseRestaurantDetailsTableViewCell.h"
#import "UXRRestaurantReviewTableViewCell+Binding.h"
#import "UXRBaseRestaurantViewController.h"
#import "UXRAttributedLabel.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>
#import "GADBannerView.h"
#import "UXRAdTableViewCell.h"
#import "GADRequest.h"
#import "GADBannerView+Request.h"
#import "GADBannerView+SpecificToIdiom.h"
#import <HTAutocompleteTextField/HTAutocompleteTextField.h>

@interface UXRBaseRestaurantTableViewController ()
@property(nonatomic,strong) NSArray *locations;
@end

@implementation UXRBaseRestaurantTableViewController

static const CGFloat yOffset = 22.0f;
static const CGFloat headerHeight = 80.0f;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self setUpHeader];
    [self setUpFooter];
}

-(void)setUpFooter{
    
    // Add a footer advertisement.
    self.adBanner = [GADBannerView bannerViewForCurrentIdiom];
    self.adBanner.adUnitID = ADMOB_ADVERTISING_KEY;
    self.adBanner.rootViewController = self;
    UIView *adView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, 200.0f)];
    [adView addSubview:self.adBanner];
    self.adBanner.center = adView.center;
    self.tableView.tableFooterView = adView;
    [self.adBanner loadRequestInRootViewController:self withDelegate:self];
}

-(void)setUpHeader{
    
    // Must destroy and recreated the header view on rotations or we get problems
    // where the user cant touch the search bar.
    if(self.tableView.tableHeaderView !=nil){
        self.tableView.tableHeaderView = nil;
    }
    
    // Header frame is adjusted for presence of a search bar, which is hidden.
    CGRect headerFrame = CGRectMake(0, 0, self.view.frame.size.width, headerHeight);
    self.headerView = [[UXRRestaurantHeaderView alloc] initWithFrame:headerFrame];
    self.tableView.tableHeaderView = self.headerView;
    [self scrollToTop];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self scrollToTop];
    self.restaurant = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // Search
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(searchBarDidSearch:)
                                                 name:SEARCH_BAR_DID_SEARCH_NOTIFICATION
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(locationBarDidUpdate:)
                                                 name:LOCATION_SEARCH_DID_END_EDITING_NOTIFICATION
                                               object:nil];
}
    
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.screenName = @"Restaurant Table View Screen";
}

#pragma mark - Search and location updates

-(void)locationBarDidUpdate:(NSNotification*)notification{
    [self scrollToTop];
}

-(void)searchBarDidSearch:(NSNotification*)notification{
    [self scrollToTop];
}

#pragma mark - Scroll actions

-(void)didTapTableView:(UITapGestureRecognizer*)tap{
    
    CGFloat offsetY = self.tableView.contentOffset.y;
    
    if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation) == YES){
        
        if(offsetY >= 0){
            [self scrollToTop];
        }
    } else {
        
        if(offsetY <= headerHeight + yOffset){
            [self scrollToTop];
        }
    }
}

-(void)scrollToTop{
    [self.headerView.searchBar resignFirstResponder];
    [self.locationSearchLabel resignFirstResponder];
    [self.tableView setContentOffset:CGPointMake(0.0f,headerHeight + yOffset) animated:YES];
}

#pragma mark - Setters

-(void)setRestaurant:(id<UXRBaseRestaurantModel>)restaurant{
    _restaurant = restaurant;
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
}

#pragma mark - Actions

-(IBAction)didTapCloseButton:(id)sender{
    [self scrollToTop];
}

#pragma mark - Scroll View Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.scrollDelegate embeddedRestaurantScrollViewDidScroll:scrollView];
}

#pragma mark - Table view data source

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == UXRReviewsSectionType){
        GADBannerView *bannerView = [GADBannerView bannerViewForCurrentIdiom];
        bannerView.adUnitID = ADMOB_ADVERTISING_KEY;
        bannerView.rootViewController = self;
        UIView *adView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, 75.0f)];
        [adView addSubview:bannerView];
        bannerView.center = adView.center;
        [bannerView loadRequestInRootViewController:self withDelegate:self];
        return adView;
    }
    else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==UXRReviewsSectionType){
        return 75.0f;
    } else {
        return 0.0f;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Hide reviews section if there are no reviews.
    if([self.restaurant restaurantReviewsArray].count > 0){
        return UXRReviewsSectionType+1;
    } else{
        return UXRReviewsSectionType;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == UXRPrimarySectionType){
        return UXRPhotoCarouselCellType + 1;
    } else{
        NSArray *reviews =[self.restaurant restaurantReviewsArray];
        return reviews.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if(indexPath.section == UXRPrimarySectionType){
        switch (indexPath.row) {
            case UXRPrimaryCellType:
                cell = [UXRRestaurantPrimaryTableViewCell cellForTableView:tableView];
                [(UXRRestaurantPrimaryTableViewCell*)cell bindToRestaurantModel:self.restaurant];
                
                if(self.tapGesture == nil){
                    // Tap gesture
                    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(didTapTableView:)];
                    [cell addGestureRecognizer:self.tapGesture];
                    self.locationSearchLabel = [(UXRRestaurantPrimaryTableViewCell*)cell locationTextField];
                }
                if(self.restaurant != nil){
                    // Toggle left/right buttons.
                    if(self.isLastRestaurant == YES){
                        [(UXRRestaurantPrimaryTableViewCell*)cell rightButton].hidden = YES;
                    } else {
                        [(UXRRestaurantPrimaryTableViewCell*)cell rightButton].hidden = NO;
                    }
                    if(self.isFirstRestaurant == YES){
                        [(UXRRestaurantPrimaryTableViewCell*)cell leftButton].hidden = YES;
                    } else {
                        [(UXRRestaurantPrimaryTableViewCell*)cell leftButton].hidden = NO;
                    }
                }
                
                break;
            case UXRMapAndDetailsCellType:{
                cell = [UXRRestaurantMapAndDetailsTableViewCell cellForTableView:tableView];
                UXRRestaurantMapAndDetailsTableViewCell *detailsCell = (UXRRestaurantMapAndDetailsTableViewCell*)cell;
                [detailsCell bindToRestaurantModel:self.restaurant];
                detailsCell.websiteLabel.delegate= (UXRBaseRestaurantViewController*)self.parentViewController;
                detailsCell.addressLabel.delegate= (UXRBaseRestaurantViewController*)self.parentViewController;
                break;
            }
            case UXRHoursCellType:
                cell = [UXRRestaurantHoursTableViewCell cellForTableView:tableView];
                [(UXRRestaurantHoursTableViewCell*)cell bindToRestaurantModel:self.restaurant];
                break;
            case UXRPhotoCarouselCellType:
                cell = [UXRPhotoCarouselTableViewCell cellForTableView:tableView];
                [(UXRPhotoCarouselTableViewCell*)cell bindToRestaurantModel:self.restaurant];
                break;
        }
    } else {
        cell = [UXRRestaurantReviewTableViewCell cellForTableView:tableView];
        NSArray *reviews =[self.restaurant restaurantReviewsArray];
        id<UXRBaseReviewModel> review = (id<UXRBaseReviewModel>)[reviews objectAtIndex:indexPath.row];
        [(UXRRestaurantReviewTableViewCell*)cell bindToReviewModel:review];
    }
    
    // enforce background invisibility
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [UIView new];
    cell.selectedBackgroundView = [UIView new];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == UXRPrimarySectionType){
        switch (indexPath.row) {
            case UXRPrimaryCellType:
                return [UXRRestaurantPrimaryTableViewCell preferredCellHeight];
            case UXRMapAndDetailsCellType:
                return [UXRRestaurantMapAndDetailsTableViewCell preferredCellHeight];
            case UXRHoursCellType:
                return [UXRRestaurantHoursTableViewCell preferredCellHeight];
            case UXRPhotoCarouselCellType:
                return [UXRPhotoCarouselTableViewCell preferredCellHeight];
            default:
                return 0.0f;
                break;
        }
    } else {
        UXRRestaurantReviewTableViewCell *cell = [UXRRestaurantReviewTableViewCell cellForTableView:tableView];
        UXRLabel *reviewLabel = cell.reviewTitleLabel;
        NSArray *reviews =[self.restaurant restaurantReviewsArray];
        id<UXRBaseReviewModel> review = (id<UXRBaseReviewModel>)[reviews objectAtIndex:indexPath.row];
        NSString *reviewTitle = [review reviewTitleText];
        
        CGFloat lineHeight = (reviewLabel.font.lineHeight );
        CGFloat lines = (reviewTitle.length / 55.0f) * lineHeight;
        CGFloat height = lines + 80.0f;
        return height;
    }
}

#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //
}

#pragma mark - Rotations

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self.tableView performSelectorOnMainThread:@selector(reloadData)
                                     withObject:nil
                                  waitUntilDone:YES];
    [self setUpHeader];
    [self eventWithAction:@"Rotate Screen" withLabel:@"Restaurant Table" andValue:0];
}

#pragma mark - GADViewDelegate Methods

- (void)adViewDidReceiveAd:(GADBannerView *)view{}
- (void)adView:(GADBannerView *)view
didFailToReceiveAdWithError:(GADRequestError *)error{}
- (void)adViewWillPresentScreen:(GADBannerView *)adView{}
- (void)adViewWillDismissScreen:(GADBannerView *)adView{}
- (void)adViewDidDismissScreen:(GADBannerView *)adView{}
- (void)adViewWillLeaveApplication:(GADBannerView *)adView{}


@end
