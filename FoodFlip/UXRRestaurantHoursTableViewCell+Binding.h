//
//  UXRRestaurantHoursTableViewCell+Binding.h
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRRestaurantHoursTableViewCell.h"
#import "UXRBaseRestaurantModel.h"

@interface UXRRestaurantHoursTableViewCell (Binding)

-(void)bindToRestaurantModel:(id<UXRBaseRestaurantModel>)model;
@end
