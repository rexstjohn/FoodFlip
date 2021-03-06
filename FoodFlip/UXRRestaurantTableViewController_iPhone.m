//
//  UXRRestaurantTableViewController_iPhone.m
//  FoodFlip
//
//  Created by Rex St. John on 1/26/14.
//  Copyright (c) 2014 UX-RX. All rights reserved.
//

#import "UXRRestaurantTableViewController_iPhone.h"
#import "UXRRestaurantPrimaryTableViewCell_iPhone.h"
#import "UXRRestaurantMapAndDetailsTableViewCell_iPhone.h"
#import "UXRRestaurantHoursTableViewCell_iPhone.h"

#import "UXRRestaurantMapAndDetailsTableViewCell+Binding.h"
#import "UXRRestaurantPrimaryTableViewCell+Binding.h"
#import "UXRPhotoCarouselTableViewCell+Binding.h"
#import "UXRRestaurantHoursTableViewCell+Binding.h"
#import "UXRBaseRestaurantDetailsTableViewCell.h"
#import "UXRBaseRestaurantViewController.h"
#import "UXRRestaurantReviewTableViewCell+Binding.h"
#import "UXRBaseHoursModel.h"
#import "UXRFourSquareRestaurantModel.h"
#import "UXRBaseRestaurantModel.h"

#import "UXRAttributedLabel.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>
#import "GADBannerView.h"
#import "UXRAdTableViewCell.h"
#import "GADRequest.h"
#import "GADBannerView+Request.h"
#import "GADBannerView+SpecificToIdiom.h"
#import <HTAutocompleteTextField/HTAutocompleteTextField.h>
#import "UXRGlobals.h"

@interface UXRRestaurantTableViewController_iPhone ()

@end

@implementation UXRRestaurantTableViewController_iPhone

static const CGFloat yOffset = 22.0f;
static const CGFloat headerHeight = 80.0f;

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if(indexPath.section == UXRPrimarySectionType){
        switch (indexPath.row) {
            case UXRPrimaryCellType:
                cell = [UXRRestaurantPrimaryTableViewCell_iPhone cellForTableView:tableView];
                [(UXRRestaurantPrimaryTableViewCell_iPhone*)cell bindToRestaurantModel:self.restaurant];
                
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
                        [(UXRRestaurantPrimaryTableViewCell_iPhone*)cell rightButton].hidden = YES;
                    } else {
                        [(UXRRestaurantPrimaryTableViewCell_iPhone*)cell rightButton].hidden = NO;
                    }
                    if(self.isFirstRestaurant == YES){
                        [(UXRRestaurantPrimaryTableViewCell_iPhone*)cell leftButton].hidden = YES;
                    } else {
                        [(UXRRestaurantPrimaryTableViewCell_iPhone*)cell leftButton].hidden = NO;
                    }
                }
                
                break;
            case UXRMapAndDetailsCellType:{
                cell = [UXRRestaurantMapAndDetailsTableViewCell_iPhone cellForTableView:tableView];
                UXRRestaurantMapAndDetailsTableViewCell_iPhone *detailsCell = (UXRRestaurantMapAndDetailsTableViewCell_iPhone*)cell;
                [detailsCell bindToRestaurantModel:self.restaurant];
                detailsCell.websiteLabel.delegate= (UXRBaseRestaurantViewController*)self.parentViewController;
                detailsCell.addressLabel.delegate= (UXRBaseRestaurantViewController*)self.parentViewController;
                break;
            }
            case UXRHoursCellType:
                cell = [UXRRestaurantHoursTableViewCell_iPhone cellForTableView:tableView];
                [(UXRRestaurantHoursTableViewCell_iPhone*)cell bindToRestaurantModel:self.restaurant];
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
                return [UXRRestaurantPrimaryTableViewCell_iPhone preferredCellHeight];
            case UXRMapAndDetailsCellType:
                return [UXRRestaurantMapAndDetailsTableViewCell_iPhone preferredCellHeight];
            case UXRHoursCellType:
                return [UXRRestaurantHoursTableViewCell_iPhone preferredCellHeight];
            case UXRPhotoCarouselCellType:
                return [UXRPhotoCarouselTableViewCell preferredCellHeight];
            default:
                return 0.0f;
                break;
        }
    } else {
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        CGFloat heightAdjustement = (UIInterfaceOrientationIsLandscape(orientation) == NO)?80:80;
        CGFloat charactersPerLine = (UIInterfaceOrientationIsLandscape(orientation) == NO)?19:41;
        
        UXRRestaurantReviewTableViewCell *cell = [UXRRestaurantReviewTableViewCell cellForTableView:tableView];
        UXRLabel *reviewLabel = cell.reviewTitleLabel;
        NSArray *reviews =[self.restaurant restaurantReviewsArray];
        id<UXRBaseReviewModel> review = (id<UXRBaseReviewModel>)[reviews objectAtIndex:indexPath.row];
        NSString *reviewTitle = [review reviewTitleText];
        CGFloat lineHeight = (reviewLabel.font.lineHeight );
        CGFloat lines = (reviewTitle.length / charactersPerLine) * lineHeight;
        CGFloat height = lines + heightAdjustement;
        return height;
    }
}

#pragma mark - Rotations

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self.tableView performSelectorOnMainThread:@selector(reloadData)
                                     withObject:nil
                                  waitUntilDone:YES];
    [self setUpHeader];
    [self eventWithAction:@"Rotate Screen" withLabel:@"Restaurant Table" andValue:0];
}
@end
