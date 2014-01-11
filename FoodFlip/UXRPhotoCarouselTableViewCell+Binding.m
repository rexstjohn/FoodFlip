//
//  UXRPhotoCarouselTableViewCell+Binding.m
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRPhotoCarouselTableViewCell+Binding.h"
#import "UXRBasePhotoModel.h"
#import "UXRGlobals.h"
#import "UXRBaseNetworkingEngine.h"
#import <MKNetworkKit/MKNetworkKit.h>

@implementation UXRPhotoCarouselTableViewCell (Binding)

-(void)bindToRestaurantModel:(id<UXRBaseRestaurantModel>)model{
    
    NSInteger photosCount = [model restaurantPhotosArray].count;
    int photoCount = (photosCount >= 14)?14:photosCount;
    NSMutableArray *photos = [[NSMutableArray alloc] initWithCapacity:photoCount];
    for(int i = 0; i < photoCount; i++){
        UIImage *image = [UIImage imageNamed:NOPHOTO_IMAGE_PATH];
        [photos addObject:image];
    }
    
    [self.photoCarousel setImageDimensions:CGSizeMake(self.frame.size.height,self.frame.size.height)];
    [self.photoCarousel setPhotoItemViews:photos];
    
    for(int i = 0; i < photoCount; i++){
        id<UXRBasePhotoModel> photo = (id<UXRBasePhotoModel>)[[model restaurantPhotosArray] objectAtIndex:i];
        UIImageView *imageView = (UIImageView*)self.photoCarousel.photoItemViews[i];
        [self downloadImageFromUrl:[photo photoDownloadURL] usingImageView:imageView];
    }
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
