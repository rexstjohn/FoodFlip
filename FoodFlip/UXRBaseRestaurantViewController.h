//
//  UXRBaseRestaurantViewController.h
//  FMag
//
//  Created by Rex St. John on 12/18/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UXRBaseRestaurantTableViewController.h"
#import "UXRSearchDataReciever.h"
#import "UXRImageView.h"
#import "UXRSearchDataProvider.h"
#import "UXRImageCyclingView.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>

@interface UXRBaseRestaurantViewController : GAITrackedViewController <UXRBaseRestaurantTableViewControllerDelegate, UXRSearchDataReciever, UIPopoverControllerDelegate, TTTAttributedLabelDelegate, UIAlertViewDelegate>

@property(nonatomic,strong) UXRImageCyclingView *backgroundImageCyclingView;
@property(nonatomic,strong) IBOutlet UIButton *scrollToTopButton;
@property(nonatomic,strong) id<UXRSearchDataProvider> provider;
@property(nonatomic,assign) NSInteger currentIndex;

-(IBAction)didTapScrollToTopButton:(id)sender;
-(void)embeddedRestaurantScrollViewDidScroll:(UIScrollView*)scrollView;
- (IBAction)unwindFromPhotoViewer:(UIStoryboardSegue *)unwindSegue;

@end
