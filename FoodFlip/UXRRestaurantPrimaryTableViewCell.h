//
//  UXRRestaurantHeaderTableViewCell.h
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRSmartTableViewCell.h"
#import "UXRLabel.h"
#import "UXRButton.h"
#import "UXRBaseRestaurantDetailsTableViewCell.h"
#import <HTAutocompleteTextField/HTAutocompleteTextField.h>
#import "UXRStarBarView.h"

@interface UXRRestaurantPrimaryTableViewCell : UXRBaseRestaurantDetailsTableViewCell<UITextFieldDelegate, HTAutocompleteDataSource>

@property (weak, nonatomic) IBOutlet UXRLabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UXRLabel *openNowLabel;
@property (weak, nonatomic) IBOutlet UXRLabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UXRLabel *queryLabel;

@property(nonatomic,strong) IBOutlet UXRButton *mapButton;
@property(nonatomic,strong) IBOutlet UXRButton *menuButton;
@property(nonatomic,strong) IBOutlet HTAutocompleteTextField *locationTextField;
@property(nonatomic,strong) IBOutlet UXRStarBarView *starBar;
@property(nonatomic,strong) IBOutlet UXRButton *leftButton;
@property(nonatomic,strong) IBOutlet UXRButton *rightButton;

@end
