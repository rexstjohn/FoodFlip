//
//  USPPhotoViewController.m
//  urbanspin
//
//  Created by Rex St John on 2/21/13.
//  Copyright (c) 2013 Urbanspoon. All rights reserved.
//

#import "UXRPhotoViewController.h"
#import "UXRBasePhotoModel.h"
#import "UXRBaseNetworkingEngine.h"
#import "MKNetworkOperation.h"
#import "UIViewController+SlideTransitions.h"
#import "UIImage+Color.h"
#import "UIColor+SimpleColoring.h"
#import "MBProgressHUD.h"
#import "MPFlipSegue.h"

CGFloat const kMinZoomScale = 0.5f;
CGFloat const kMaxZoomScale = 2.2f;
CGFloat const kInitialZoomScale = 0.5f;

@interface UXRPhotoViewController ()
@property (strong, atomic) MKNetworkOperation *networkOperation;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeLeftGestureRecognizer;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeRightGestureRecognizer;
@property (strong, nonatomic) UIPinchGestureRecognizer *pinchGestureRecognizer;
@property (assign, nonatomic,readwrite) NSInteger currentPhotoIndex;
@property (assign, nonatomic) CGFloat initialZoomLevel;
@end

@implementation UXRPhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    self.swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft:)];
    self.swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.swipeLeftGestureRecognizer.delegate = self; 
    [self.view addGestureRecognizer:self.swipeLeftGestureRecognizer];
    
    self.swipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
    self.swipeRightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    self.swipeRightGestureRecognizer.delegate = self; 
    [self.view addGestureRecognizer:self.swipeRightGestureRecognizer];
    
    UIColor *lightBackgroundColor = [UIColor simpleColorWithRed:0 green:0 blue:0 alpha:.15]; 
    [self.doneButton setBackgroundImage:[UIImage imageWithColor:lightBackgroundColor] forState:UIControlStateNormal];
    [self.doneButton setBackgroundImage:[UIImage imageWithColor:lightBackgroundColor] forState:UIControlStateHighlighted];
    [self.doneButton setBackgroundImage:[UIImage imageWithColor:lightBackgroundColor] forState:UIControlStateSelected];
    
    // Empty the fields
    self.authorNameLabel.text = @"";
    self.menuItemLabel.text = @"";
    self.captionLabel.text = @"";
     
    //
    [self.scrollView setBackgroundColor:[UIColor clearColor]]; 
    [self.leftButton setBackgroundColor:[UIColor clearColor]];
    [self.rightButton setBackgroundColor:[UIColor clearColor]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(_photos != nil){
        dispatch_async(dispatch_get_main_queue(),^{
            [self setPhotoProperties];
            [self toggleLeftRightButtonVisibility];
        });
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.networkOperation cancel];
    self.networkOperation = nil;
}

#pragma mark -

-(void)setPhotos:(NSArray *)photos{
    _photos = photos;
    dispatch_async(dispatch_get_main_queue(),^{
        [self setPhotoProperties];
        [self toggleLeftRightButtonVisibility];
    });
}

-(void)setPhotoProperties{
    id<UXRBasePhotoModel> currentPhoto = (id<UXRBasePhotoModel> )self.photos[self.currentPhotoIndex];
    
    // Download the best available photo.
    [self downloadImageFromUrl:[currentPhoto photoDownloadURL]];
}

#pragma mark - Scroll View Delegate

- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.photoImageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.photoImageView.frame = contentsFrame;
}

#pragma mark - UIScrollViewDelegate

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.photoImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so you need to re-center the contents
    [self centerScrollViewContents];
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale{
    [self centerScrollViewContents];
}

#pragma mark - Actions.

-(void)didSwipeLeft:(UISwipeGestureRecognizer*)recognizer{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    // Prevent the swipes from being reversed
    UIInterfaceOrientation orientation = self.interfaceOrientation;
    
    if(UIInterfaceOrientationPortraitUpsideDown == orientation){
        [self setCurrentPhotoIndex:_currentPhotoIndex - 1 animated:YES];
    } else{
        [self setCurrentPhotoIndex:_currentPhotoIndex + 1 animated:YES];
    }
    
}

-(void)didSwipeRight:(UISwipeGestureRecognizer*)recognizer{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self setCurrentPhotoIndex:_currentPhotoIndex - 1 animated:YES];
    
    // Prevent the swipes from being reversed
    UIInterfaceOrientation orientation = self.interfaceOrientation;
    
    if(UIInterfaceOrientationPortraitUpsideDown == orientation){
        [self setCurrentPhotoIndex:_currentPhotoIndex + 1 animated:YES];
    } else{
        [self setCurrentPhotoIndex:_currentPhotoIndex - 1 animated:YES];
    }
}

- (IBAction)leftPageArrowTouch:(id)sender {
    [self setCurrentPhotoIndex:_currentPhotoIndex - 1 animated:YES];
}

- (IBAction)rightPageArrowTouch:(id)sender {
    [self setCurrentPhotoIndex:_currentPhotoIndex + 1 animated:YES];
}

-(void)setCurrentPhotoIndex:(NSInteger)nextPhotoIndex animated:(BOOL)animated{
    
    // Reset the networkOperation.
    [self.networkOperation cancel];
    self.networkOperation = nil;
    
    
    BOOL isNotFirstIndex = nextPhotoIndex >= 0;
    BOOL isNotLastIndex = nextPhotoIndex < self.photos.count;
    
    if(isNotFirstIndex == YES && isNotLastIndex == YES ){
        if(animated == YES){
            NSString *direction = (_currentPhotoIndex > nextPhotoIndex)?kCATransitionFromLeft:kCATransitionFromRight;
            
            if (UIInterfaceOrientationPortrait == [[UIApplication sharedApplication] statusBarOrientation]) {
                direction = (_currentPhotoIndex > nextPhotoIndex)?kCATransitionFromLeft:kCATransitionFromRight;
            } else if(UIInterfaceOrientationLandscapeLeft == [[UIApplication sharedApplication] statusBarOrientation]){
                direction = (_currentPhotoIndex > nextPhotoIndex)?kCATransitionFromTop:kCATransitionFromBottom;
            } else if(UIInterfaceOrientationLandscapeRight == [[UIApplication sharedApplication] statusBarOrientation]){
                direction = (_currentPhotoIndex > nextPhotoIndex)?kCATransitionFromBottom:kCATransitionFromTop;
            }
            
            [self transitionFromView:self.photoImageView
                              toView:self.photoImageView
                  usingContainerView:self.view andTransition:direction];
        }
        _currentPhotoIndex = nextPhotoIndex;
        [self setPhotoProperties]; 
    } else {
        if(nextPhotoIndex == -1){
            _currentPhotoIndex = 0;
            [self setPhotoProperties];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }
    [self toggleLeftRightButtonVisibility];
}

- (IBAction)doneButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"UnwindPhotoViewerSegue" sender:self];
}

-(void)toggleLeftRightButtonVisibility{ 
    self.leftButton.hidden = _currentPhotoIndex == 0;
    self.rightButton.hidden = _currentPhotoIndex == self.photos.count-1 ; 
}

#pragma mark - Rotation handling

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
    // Don't do this if the imageview doesnt exist yet.
    if(self.photoImageView == nil){
        return;
    }
    [UIView animateWithDuration:duration animations:^{
        self.photoImageView.alpha = 0;
        [self centerScrollViewContents];
    }];
} 

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    // Don't do this if the imageview doesnt exist yet.
    if(self.photoImageView == nil){
        return;
    }
    // Seems we have to tear down and recreate the image view or this wont work.
    [self.photoImageView removeFromSuperview];
    UIImage *oldImage = self.photoImageView.image;
    self.photoImageView = nil; 
    self.photoImageView = [[UIImageView alloc] initWithImage:oldImage];
    self.photoImageView.frame = self.scrollView.frame;
    [self.photoImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.scrollView addSubview:self.photoImageView];
    [self.photoImageView setUserInteractionEnabled:YES];
    [self calculateScrollViewScale]; 
    self.scrollView.zoomScale = self.initialZoomLevel;
    [self centerScrollViewContents];
    [UIView animateWithDuration:.5 animations:^{
        self.photoImageView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Image Downloading

-(void)downloadImageFromUrl:(NSURL*)url {
    
    // abort early if there is no network connection
    
    // Set the placeholder image.
    self.photoImageView.image = [UIImage imageNamed:@"tile_nophoto.png"];
    __weak UXRPhotoViewController *weakSelf = self;
    
    // Download or get the cached image.
    UXRBaseNetworkingEngine * sharedEngine = [UXRBaseNetworkingEngine sharedInstance];
    self.networkOperation = [sharedEngine imageAtURL:url completionHandler:^(UIImage *fetchedImage, NSURL *fetchedURL, BOOL isInCache) {
        if(url == fetchedURL){  //This check is necessary as tableview cells might be recycled and a cell might end up getting images from multiple network operations.
             
                if(self.photoImageView == nil){
                    self.photoImageView = [[UIImageView alloc] initWithImage:fetchedImage];
                    self.photoImageView.frame = self.scrollView.frame;
                    [self.photoImageView setContentMode:UIViewContentModeScaleAspectFit];
                    [self.scrollView addSubview:self.photoImageView];
                    [self.photoImageView setUserInteractionEnabled:YES];
                    [self calculateScrollViewScale];
                } else {
                    self.photoImageView.image = fetchedImage;
                }
            self.scrollView.zoomScale = self.initialZoomLevel;
          [self centerScrollViewContents];
        }
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}

-(void)calculateScrollViewScale{
    [self.scrollView setContentSize:self.photoImageView.frame.size];
    CGRect scrollViewFrame = self.scrollView.frame;
    
    CGFloat scaleWidth;
    CGFloat scaleHeight;
    scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;

    CGFloat minScale = MAX(scaleWidth, scaleHeight);
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = kMaxZoomScale;
    self.initialZoomLevel=minScale;
}


@end
