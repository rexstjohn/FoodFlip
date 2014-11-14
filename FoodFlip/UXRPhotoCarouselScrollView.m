//
//  USPPhotoCarouselScrollView.m
//  UXRX
//
//  Created by Rex St John on 3/25/13.
//  Copyright (c) 2013 UXRX. All rights reserved.
//

#import "UXRPhotoCarouselScrollView.h"
#import "UXRGlobals.h"
#import "UXRPhotoViewController.h"

@interface UXRPhotoCarouselScrollView()
@property(nonatomic,strong) NSArray *buttons;
@end

@implementation UXRPhotoCarouselScrollView

static const CGSize DEFAULT_IMAGE_SIZE = {75.0f, 75.0f};
static const UIEdgeInsets DEFAULT_IMAGE_INSETS = {1.0f,2.5f,1.0f,2.5f};

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setPhotoItemViews:@[[UIImage imageNamed:NOPHOTO_IMAGE_PATH]]];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator=NO;
        self.imageDimensions = DEFAULT_IMAGE_SIZE;
        self.imageEdgeInsets = DEFAULT_IMAGE_INSETS;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setPhotoItemViews:@[[UIImage imageNamed:NOPHOTO_IMAGE_PATH]]];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator=NO;
        self.imageDimensions = DEFAULT_IMAGE_SIZE;
        self.imageEdgeInsets = DEFAULT_IMAGE_INSETS;
    }
    return self;
}

-(void)setPhotoItemViews:(NSArray *)photoItemViews{
    
    if(_photoItemViews != nil){
        for(UIImageView *imageView in self.photoItemViews){
            [imageView removeFromSuperview];
        }
        for(UIButton *button in self.buttons){
            [button removeFromSuperview];
        }
    }
    
    CGFloat widthInset = 0.0f;//self.imageEdgeInsets.left + self.imageEdgeInsets.right;
    CGFloat heightInset = 0.0f;//self.imageEdgeInsets.top + self.imageEdgeInsets.bottom;
    NSMutableArray *itemViews = [[NSMutableArray alloc] init];
    for(int i = 0; i < photoItemViews.count; i++){
        CGRect photoRect = CGRectMake(widthInset + (i * _imageDimensions.width + (i*widthInset)),
                                      heightInset, _imageDimensions.width+widthInset,
                                      _imageDimensions.width+heightInset);
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:photoRect];
        [imageView setImage: (UIImage*)photoItemViews[i]];  
        [self addSubview:imageView];
        [itemViews addObject:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = imageView.frame;
        button.tag = i;
        [self addSubview:button];
        button.center = imageView.center;
        [button addTarget:self action:@selector(didTapImageView:) forControlEvents:UIControlEventTouchUpInside];
    }
    _photoItemViews = [NSArray arrayWithArray:itemViews];
    
    self.contentSize = CGSizeMake(widthInset + (photoItemViews.count * _imageDimensions.width + (photoItemViews.count*widthInset)), _imageDimensions.height + heightInset);
    [self setNeedsLayout];
}

-(void)didTapImageView:(UIButton*)sender{
    UIImageView *imageView = self.photoItemViews[sender.tag];
    imageView.tag = sender.tag;
    [[NSNotificationCenter defaultCenter] postNotificationName:PHOTO_WAS_SELECTED_NOTIFICATION object:imageView];
    
}

@end
