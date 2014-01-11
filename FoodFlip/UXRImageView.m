//
//  UXRImageView.m
//  FMag
//
//  Created by Rex St. John on 12/19/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRImageView.h"
#import "MKNetworkKit.h"
#import "UXRGlobals.h"
#import "UXRBaseNetworkingEngine.h"

@interface UXRImageView()
@property (strong, atomic) MKNetworkOperation *networkOperation;
@property (nonatomic,strong) UIActivityIndicatorView *indicator;
@end

@implementation UXRImageView

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if(self){
        self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.indicator startAnimating];
//        [self addSubview:self.indicator];
    }
    
    return self;
}

-(void)downloadImageFromUrl:(NSURL*)url
     loadImageAutomatically:(BOOL)shouldReplaceAuto
        withCompletionBlock:(UXRImageViewEngineCompletionBlock)completion
                   andError:(UXRImageViewErrorBlock)errorBlock{
    
    [self.networkOperation cancel];
    self.networkOperation = nil;
    
    if(shouldReplaceAuto == YES){
        // Set the placeholder image.
        self.image = [UIImage imageNamed:NOPHOTO_IMAGE_PATH];
    }
    
    // Download or get the cached image.
    UXRBaseNetworkingEngine * sharedEngine = [UXRBaseNetworkingEngine sharedInstance];
    self.networkOperation = [sharedEngine imageAtURL:url
                                   completionHandler:^(UIImage *fetchedImage, NSURL *fetchedURL, BOOL isInCache) {
         [self.indicator removeFromSuperview];
        if(url == fetchedURL){  //This check is necessary as tableview cells might be recycled and a cell might end up getting images from multiple network operations.
            // we don't always want to automatically set the image.
            if(shouldReplaceAuto == YES){
                self.image = fetchedImage;
            }
            [self setNeedsDisplay];
            
            if(completion != nil){
                completion(fetchedImage);
            }
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        // TODO: Handler Error.
        // Set the image to "Image couldnt be downloaded / broken image" graphic or leave as placeholder.
        [self.indicator removeFromSuperview];
        if(error != nil){
            errorBlock(error);
        }
    }];
}

-(void)dealloc{
    [self.networkOperation cancel];
    self.networkOperation = nil;
}

@end
