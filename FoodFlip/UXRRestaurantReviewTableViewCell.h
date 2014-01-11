//
//  UXRRestaurantReviewTableViewCell.h
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRSmartTableViewCell.h"
#import "UXRLabel.h"
#import "UXRBaseRestaurantDetailsTableViewCell.h"
#import <MKNetworkKit/MKNetworkKit.h>

@interface UXRRestaurantReviewTableViewCell : UXRBaseRestaurantDetailsTableViewCell
@property (weak, nonatomic) IBOutlet UXRLabel *reviewTitleLabel;
@property (weak, nonatomic) IBOutlet UXRLabel *reviewBodyLabel;
@property (weak, nonatomic) IBOutlet UXRLabel *reviewerNameLabel;
@property (weak, nonatomic) IBOutlet UXRLabel *reviewerDetailsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *reviewerPhotoImageView;
@property (strong, atomic) MKNetworkOperation *networkOperation;

@end
