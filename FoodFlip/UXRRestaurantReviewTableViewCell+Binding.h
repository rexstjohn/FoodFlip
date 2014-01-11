//
//  UXRRestaurantReviewTableViewCell+Binding.h
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRRestaurantReviewTableViewCell.h"
#import "UXRBaseReviewModel.h"

@interface UXRRestaurantReviewTableViewCell (Binding)

-(void)bindToReviewModel:(id<UXRBaseReviewModel>)model;

@end
