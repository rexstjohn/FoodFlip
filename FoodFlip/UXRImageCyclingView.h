//
//  UXRImageCyclingView.h
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRSmartView.h"
#import "UXRImageView.h"

@interface UXRImageCyclingView : UXRSmartView
@property(nonatomic,strong) IBOutlet UXRImageView *topImageView;
@property(nonatomic,strong) IBOutlet UIImageView *bottomImageView;
@property(nonatomic,strong,readonly) UIImage *topImage;
@property(nonatomic,strong,readonly) UIImage *bottomImage;
-(void)setImages:(NSArray*)images;
@end
