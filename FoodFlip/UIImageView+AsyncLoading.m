//
//  UIImageView+AsyncLoading.m
//  urbanspin
//
//  Created by Rex St John on 1/18/13.
//  Copyright (c) 2013 Urbanspoon. All rights reserved.
//

#import "UIImageView+AsyncLoading.h"
#import "UXRYelpNetworkingEngine.h"

@implementation UIImageView (AsyncLoading)

-(void)downloadImageFromUrl:(NSURL*)url withPlaceholderNamed:(NSString*)placeholderImageName{
    
    // Set the placeholder image.
    self.image = [UIImage imageNamed:placeholderImageName];
    
    // Download or get the cached image.
    UXRYelpNetworkingEngine * sharedEngine = [UXRYelpNetworkingEngine sharedInstance];
    [sharedEngine imageAtURL:url completionHandler:^(UIImage *fetchedImage, NSURL *fetchedURL, BOOL isInCache) {
        if(url == fetchedURL){  //This check is necessary as tableview cells might be recycled and a cell might end up getting images from multiple network operations.
            self.image = fetchedImage;
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        // TODO: Handler Error.
        // Set the image to "Image couldnt be downloaded / broken image" graphic or leave as placeholder.
    }];
}

@end
