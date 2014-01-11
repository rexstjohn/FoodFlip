//
//  UXRRestaurantReviewTableViewCell+Binding.m
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRRestaurantReviewTableViewCell+Binding.h"
#import "UXRBaseReviewModel.h"
#import "UXRBaseUserModel.h"
#import "UXRBasePhotoModel.h"
#import "UXRBaseNetworkingEngine.h"
#import <MKNetworkKit/MKNetworkKit.h>

@implementation UXRRestaurantReviewTableViewCell (Binding)

-(void)bindToReviewModel:(id<UXRBaseReviewModel>)model{
    self.reviewTitleLabel.text = [model reviewTitleText];
    self.reviewBodyLabel.text = [model reviewBodyText];
    [self.reviewBodyLabel sizeToFit];
    id<UXRBaseUserModel> user = (id<UXRBaseUserModel>)[model reviewUserAuthor];
    self.reviewerNameLabel.text = [user userDisplayName];
    NSURL *userPhotoURL = [[user userPhoto] photoDownloadURL];
    [self downloadImageFromUrl:userPhotoURL usingImageView:self.reviewerPhotoImageView];
    self.reviewerDetailsLabel.text = [user userDescriptionText];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.reviewTitleLabel sizeToFit];
        [self.reviewTitleLabel setNeedsLayout];
    });
}

-(void)downloadImageFromUrl:(NSURL*)url usingImageView:(UIImageView*)imageView{
    
    // Set the placeholder image.
    __block UIImageView *targetImageView = imageView;
    
    // Download or get the cached image.
    UXRBaseNetworkingEngine * sharedEngine = [UXRBaseNetworkingEngine sharedInstance];
    
    self.networkOperation = [sharedEngine imageAtURL:url completionHandler:^(UIImage *fetchedImage, NSURL *fetchedURL, BOOL isInCache) {
        if(url == fetchedURL){  //This check is necessary as tableview cells might be recycled and a cell might end up getting images from multiple network operations.
            targetImageView.image = fetchedImage;
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        // TODO: Handler Error.
        // Set the image to "Image couldnt be downloaded / broken image" graphic or leave as placeholder.
    }];
}

-(void)dealloc{
    [self.networkOperation cancel];
    self.networkOperation = nil;
}

@end

UIImageView *reviewerPhotoImageView;
