//
//  UXRImageCyclingView.m
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRImageCyclingView.h"
#import "UIImage+StackBlur.h"
#import "UIImageView+CrossFade.h"
#import "UIImage+Colorize.h"
#import "UXRGlobals.h"

@interface UXRImageCyclingView()
@property(nonatomic,strong,readwrite) UIImage *topImage;
@property(nonatomic,strong,readwrite) UIImage *bottomImage;
@property(nonatomic,strong) NSTimer *updateTimer;
@property(nonatomic,strong) NSArray *images;
@property(nonatomic,assign) NSInteger imageIndex;
@end

@implementation UXRImageCyclingView

static const NSTimeInterval secondsDelay = 7.0;

+ (NSString *)viewIdentifier {
    static NSString* _viewIdentifier = @"UXRImageCyclingView";
    _viewIdentifier = NSStringFromClass([self class]);
    return _viewIdentifier;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.topImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.bottomImageView.contentMode = UIViewContentModeScaleAspectFill;
}

-(void)setImages:(NSArray*)images{
    
    self.topImage = nil;
    self.bottomImage = nil;
    
    if(images.count == 0){
        return;
    }
    
    _images = images;
    self.imageIndex = 0;//rand() % (images.count - 0) + 0;
    NSURL *imageURL = (NSURL*)[images objectAtIndex:self.imageIndex];
    [self setImageURL:imageURL];
    
//    [self.updateTimer invalidate];
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:secondsDelay
//                                                      target:self
//                                                    selector:@selector(updatePhoto:)
//                                                    userInfo:nil
//                                                     repeats:YES];
//    self.updateTimer = timer;
}

-(void)setImageURL:(NSURL *)imageURL{
    
    __weak UXRImageCyclingView *weakSelf = self;
    self.bottomImageView.image = nil;
    [self.topImageView downloadImageFromUrl:imageURL
                     loadImageAutomatically:YES
                               withCompletionBlock:^(UIImage *resultingImage) {
                                   // Alter the image.
                                   UIColor *darkColor = [UIColor colorWithWhite:0.0f alpha:0.85f];
                                   UIImage *blurredImage = [resultingImage stackBlur:3.0f];
                                   blurredImage = [UIImage colorizeImage:blurredImage withColor:darkColor];
                                   [weakSelf.topImageView crossFadeToImage:resultingImage];
                                   [weakSelf.bottomImageView crossFadeToImage:blurredImage];
                                   self.topImage = resultingImage;
                                   self.bottomImage = blurredImage;
                               } andError:^(NSError *error) {
                                   //
                               }];
}

-(void)updatePhoto:(id)sender{
    
    if(self.imageIndex + 1 > self.images.count - 1){
        self.imageIndex = 0;
    } else{
        self.imageIndex++;
    }
    NSURL *imageURL = (NSURL*)[self.images objectAtIndex:self.imageIndex];
    [self setImageURL:imageURL];
}

-(void)dealloc{
    [self.updateTimer invalidate];
    self.updateTimer = nil;
    self.topImageView = nil;
    self.bottomImageView = nil;
}

@end
