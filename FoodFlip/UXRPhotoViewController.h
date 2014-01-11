//
//  USPPhotoViewController.h
//  urbanspin
//
//  Created by Rex St John on 2/21/13.
//  Copyright (c) 2013 Urbanspoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UXRLabel.h"
#import "UXRButton.h"

@interface UXRPhotoViewController : GAITrackedViewController <UIGestureRecognizerDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UXRLabel *authorNameLabel;
@property (weak, nonatomic) IBOutlet UXRLabel *menuItemLabel;
@property (weak, nonatomic) IBOutlet UXRLabel *captionLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UXRButton *leftButton;
@property (weak, nonatomic) IBOutlet UXRButton *rightButton;
@property (weak, nonatomic) IBOutlet UXRButton *doneButton;
@property (nonatomic, assign) BOOL doSlideAnimation;
@property (copy, nonatomic) NSArray *photos;
@property (assign, nonatomic,readonly) NSInteger currentPhotoIndex;
@property (strong, nonatomic) UIImageView *photoImageView;

- (void)setCurrentPhotoIndex:(NSInteger)currentPhotoIndex animated:(BOOL)animated;
- (IBAction)doneButtonAction:(id)sender;
- (IBAction)leftPageArrowTouch:(id)sender;
- (IBAction)rightPageArrowTouch:(id)sender;
@end
