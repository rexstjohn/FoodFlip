//
//  UXRRestaurantHoursTableViewCell.h
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRSmartTableViewCell.h"
#import "UXRBaseRestaurantDetailsTableViewCell.h"
#import "UXRLabel.h"

@interface UXRRestaurantHoursTableViewCell : UXRBaseRestaurantDetailsTableViewCell

@property (weak, nonatomic) IBOutlet UXRLabel *hoursColumnOneLabel;
@property (weak, nonatomic) IBOutlet UXRLabel *hoursColumnTwoLabel;


@end
