//
//  UXRRestaurantMapAndDetailsTableViewCell+Binding.h
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRRestaurantMapAndDetailsTableViewCell.h"
#import "UXRBaseRestaurantModel.h"

@interface UXRRestaurantMapAndDetailsTableViewCell (Binding)

-(void)bindToRestaurantModel:(id<UXRBaseRestaurantModel>)model;

@end
