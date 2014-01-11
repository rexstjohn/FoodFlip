//
//  UXRPhotoCarouselTableViewCell.h
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//
 
#import "UXRBaseRestaurantDetailsTableViewCell.h"
#import "UXRPhotoCarouselScrollView.h"
#import <MKNetworkKit/MKNetworkOperation.h>

@interface UXRPhotoCarouselTableViewCell : UXRBaseRestaurantDetailsTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *photoTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (strong, atomic) MKNetworkOperation *networkOperation;
@property (weak, nonatomic) IBOutlet UXRPhotoCarouselScrollView *photoCarousel;
@end
