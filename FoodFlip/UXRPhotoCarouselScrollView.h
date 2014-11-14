//
//  USPPhotoCarouselScrollView.h
//  UXRX
//
//  Created by Rex St John on 3/25/13.
//  Copyright (c) 2013 UXRX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UXRPhotoCarouselScrollView : UIScrollView

@property (strong, nonatomic) NSArray *photoItemViews;
@property (assign, nonatomic) CGSize imageDimensions;
@property (assign, nonatomic) UIEdgeInsets imageEdgeInsets;
@end
