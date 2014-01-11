//
//  UXRRestaurantHeaderView.h
//  FMag
//
//  Created by Rex St. John on 12/18/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UXRSmartView.h"
#import "UXRLabel.h"

@interface UXRRestaurantHeaderView : UXRSmartView <UISearchBarDelegate>
@property(nonatomic,strong) IBOutlet UIButton *closeButton;
@property(nonatomic,strong) IBOutlet UISearchBar *searchBar;
@end
