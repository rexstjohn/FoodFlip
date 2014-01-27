//
//  UXRBaseRestaurantViewController.m
//  FMag
//
//  Created by Rex St. John on 12/18/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRBaseRestaurantViewController.h"
#import "UXRBaseRestaurantTableViewController.h"
#import "UXRRestaurantHeaderView.h"
#import "UXRFourSquareDataManager.h"
#import "UXRBaseRestaurantModel.h"
#import "UXRGlobals.h"
#import "UIStoryboard+CreateFromClass.h"
#import "UIStoryboard+storyboardWithUniversalName.h"
#import "UXRBasePhotoModel.h"
#import "UXRImageCyclingView.h"
#import "UXRPhotoViewController.h"
#import "UXRWebViewController.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>
#import "MBProgressHUD.h"
#import <MPFoldTransition/MPFlipSegue.h>

@interface UXRBaseRestaurantViewController ()
@property(nonatomic,strong) UXRBaseRestaurantTableViewController *restaurantTableViewController;
@property(nonatomic,strong) NSArray *restaurants;
@property(nonatomic,strong) id<UXRBaseRestaurantModel> selectedRestaurant;
@property(nonatomic,strong) UIPopoverController *filtersPopover;
@end

@implementation UXRBaseRestaurantViewController

#pragma mark - View Lifecycle

// this method is called when using storyboards; initWithNibName is never called when using storyboards
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.provider = [UXRFourSquareDataManager sharedManager];
    }
    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //
    self.backgroundImageCyclingView = [[UXRImageCyclingView alloc] initWithFrame:self.view.frame];
    [self.view insertSubview:self.backgroundImageCyclingView atIndex:0];
    self.backgroundImageCyclingView.center = self.view.center;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didRecieveShareRequest:)
                                                 name:SHARE_REQUEST_NOTIFICATION
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadMap:)
                                                 name:MAP_BUTTON_REQUESTED_OPEN_NOTIFICATION
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showPhotoViewer:)
                                                 name:PHOTO_WAS_SELECTED_NOTIFICATION
                                               object:nil];
    
    // We don't want to trigger the load again if we have results.
    // This may need to move someplace else in the future depending on the type of call (nearby etc)
    BOOL hasResults = [self.provider getResponseResults].count > 0;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if(hasResults == NO){
        NSNotification *updateNotification = [NSNotification notificationWithName:REQUEST_RESTAURANT_DATA_UPDATE_NOTIFICATION object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:updateNotification];
    } else {
        _restaurants = [self.provider getResponseResults];
        NSInteger providerIndex = [self.provider getSelectedRestaurantIndex];
        self.selectedRestaurant = (id<UXRBaseRestaurantModel>)[self.restaurants objectAtIndex:providerIndex];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.screenName = @"Restaurant View Screen";
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)didReceiveMemoryWarning{
    //
}

#pragma mark - UXRSearchDataReciever Methods

-(void)restaurantDataDidBeginUpdates:(NSNotification*)notification{
    // Show loader
}

-(void)restaurantDataDidUpdate:(NSNotification*)notification{
    
    // Hide loader.
    NSArray *restaurants = [self.provider getResponseResults];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // Empty results may be returned, we need to make sure only to update with actual results.
        if(restaurants.count > 0){
            self.restaurants = restaurants;
            self.selectedRestaurant = (id<UXRBaseRestaurantModel>)[self.restaurants
                                                                   objectAtIndex:self.currentIndex];
        } else {
            NSLog(@"Error: No restaurants returned");
        }
    });
}

-(void)restaurantDataUpdateDidFailWithError:(NSNotification*)notification{
    // Hide loader;
    
    // No results message.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Results Were Returned" message:@"Search Again?" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

#pragma mark - Restaurant Table View Delegate Methods

-(void)embeddedRestaurantScrollViewDidScroll:(UIScrollView*)scrollView{
    CGFloat scrollAlpha = 1 - (scrollView.contentOffset.y / scrollView.frame.size.height);
    self.backgroundImageCyclingView.topImageView.alpha = scrollAlpha;
    
    // If the user has scrolled down...
    if(scrollAlpha <= 0.45f){
        [UIView animateWithDuration:0.25f animations:^{
            self.scrollToTopButton.alpha = 1;
        }];
    } else {
        [UIView animateWithDuration:0.25f animations:^{
            self.scrollToTopButton.alpha = 0;
        }];
    }
}

#pragma mark - Setters

-(void)setSelectedRestaurant:(id<UXRBaseRestaurantModel>)selectedRestaurant{
    
    __weak UXRBaseRestaurantViewController *weakSelf = self;
    NSString *title = [selectedRestaurant displayName];
    NSString *restaurantId = [selectedRestaurant restaurantIdentifier];
    [self.provider getFullRestaurantWithId:restaurantId
                                completion:^(id<UXRBaseRestaurantModel> restaurant) {
        
        // Have to prevent intercepting the wrong load signal.
        // The shared networking engine may have many calls of this type in action.
        // To prevent that we need to check the result.
        NSString *restaurantId = [restaurant displayName];
        if([title isEqualToString:restaurantId] == YES){
            NSMutableArray *urls = [NSMutableArray arrayWithCapacity:[restaurant restaurantPhotosArray].count];
            
            for(id<UXRBasePhotoModel> photo in [restaurant restaurantPhotosArray]){
                [urls addObject:[photo photoDownloadURL]];
            }
            
            [weakSelf.backgroundImageCyclingView setImages:(NSArray*)urls];
            
            // Toggle the arrows.
            NSInteger providerIndex = [self.provider getSelectedRestaurantIndex];
            if(providerIndex == 0){
                weakSelf.restaurantTableViewController.isFirstRestaurant = YES;
            }else {
                weakSelf.restaurantTableViewController.isFirstRestaurant = NO;
            }
            if(providerIndex == self.restaurants.count-1){
                weakSelf.restaurantTableViewController.isLastRestaurant = YES;
            } else {
                weakSelf.restaurantTableViewController.isLastRestaurant = NO;
            }
            
            _selectedRestaurant = restaurant;
            weakSelf.restaurantTableViewController.restaurant = _selectedRestaurant;
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        });
    } error:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        });
    }];
    
}

#pragma mark - TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    [self performSegueWithIdentifier:@"LoadWebViewSegue" sender:url];
}

- (void)attributedLabel:(TTTAttributedLabel *)label
didSelectLinkWithAddress:(NSDictionary *)addressComponents{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Open Maps?"
                                                    message:@"Viewing directions will take you to another application. Do you want to proceed?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel" otherButtonTitles:@"Get Directions", nil];
    [alert show];
}

#pragma mark - AlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.cancelButtonIndex == buttonIndex){
        return;
    } else {
        CLLocation *location = [self.selectedRestaurant restaurantLocation];
        CLLocationCoordinate2D coordinate = location.coordinate;
        MKPlacemark* placeMark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
        MKMapItem* destination =  [[MKMapItem alloc] initWithPlacemark:placeMark];
        
        if([destination respondsToSelector:@selector(openInMapsWithLaunchOptions:)])
        {
            //using iOS6 native maps app
            [destination openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving}];
        }
    }
}

#pragma mark - Actions

-(IBAction)didTapScrollToTopButton:(id)sender{
    [self.restaurantTableViewController scrollToTop];
}

-(void)loadMap:(NSNotification*)sender{
    [self performSegueWithIdentifier:@"MapSegue" sender:sender];
}

-(void)showPhotoViewer:(NSNotification*)notification{
    if([notification.object isMemberOfClass:[UIImageView class]] == YES){
        UIImageView *imageView = (UIImageView*)notification.object;
        [self performSegueWithIdentifier:@"LoadPhotoSegue" sender:imageView];
    } else {
        NSLog(@"Error: Not an image view");
    }
}

-(void)didRecieveShareRequest:(NSNotification*)notification{
    
    [self eventWithAction:kSELECTACTION withLabel:@"Share Restaurant" andValue:0];
    NSString *textToShare = @"Check out this restaurant I found with FoodFlip!";
    NSString *titleToShare = [NSString stringWithFormat:@"%@, %@",[self.selectedRestaurant displayName], [self.selectedRestaurant readibleAddressString]];
    NSString *urlToShare = [self.selectedRestaurant primaryRestaurantWebsiteURLPathString];
    UIImage *imageToShare = self.backgroundImageCyclingView.topImage;
    NSArray *itemsToShare = @[textToShare,titleToShare,urlToShare, imageToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
}

#pragma mark - Segues

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    BOOL shouldSegue = YES;
    NSInteger restaurantCount = [self.provider getResponseResults].count;
    NSInteger currentSelectedIndex = [self.provider getSelectedRestaurantIndex];
    
    if ([identifier isEqualToString:@"FlipForwardSegue"]){
        if(currentSelectedIndex + 1 == restaurantCount){
            shouldSegue = NO;
        } else {
            currentSelectedIndex += 1;
        }
        [self.provider setSelectedRestaurantIndex:currentSelectedIndex];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } else if([identifier isEqualToString:@"FlipBackwardSegue"]){
        if(currentSelectedIndex - 1 < 0 || self.navigationController.viewControllers.count == 1){
            shouldSegue = NO;
        } else {
            currentSelectedIndex -= 1;
        }
        [self.provider setSelectedRestaurantIndex:currentSelectedIndex];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    
    return shouldSegue;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSString *segueId = [segue identifier];
    
    if([segueId isEqualToString:@"EmbedSegue"]){
        self.restaurantTableViewController = (UXRBaseRestaurantTableViewController *)[segue destinationViewController];
        self.restaurantTableViewController.scrollDelegate = self;
    } else if([segueId isEqualToString:@"FilterOptionsSegue"]){
        
    } else if([segueId isEqualToString:@"LoadPhotoSegue"]){
        UXRPhotoViewController *photoViewer = (UXRPhotoViewController *)[segue destinationViewController];
        UIImageView *senderView = (UIImageView*)sender;
        [photoViewer setPhotos:[self.selectedRestaurant restaurantPhotosArray]];
        [photoViewer setCurrentPhotoIndex:senderView.tag animated:YES];
    } else if ([segueId isEqualToString:@"LoadWebViewSegue"]){
        NSURL *url = (NSURL*)sender;
        UXRWebViewController *webViewController = (UXRWebViewController *)[segue destinationViewController];
        [webViewController navigateToURL:url];
    }
}

#pragma mark - Unwind Segue

- (IBAction)unwindFromPhotoViewer:(UIStoryboardSegue *)unwindSegue{}

#pragma mark - UIPopoverControllerDelegate

-(BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController{
    return YES;
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController*)controller{}

@end
