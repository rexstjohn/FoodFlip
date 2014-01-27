//
//  UXRStarBarView.h
//  FMag
//
//  Created by Rex St. John on 12/27/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRSmartView.h"
#import "UXRStarView.h"

@interface UXRStarBarView : UXRSmartView

@property (strong, nonatomic) IBOutlet UXRStarView *starOne;
@property (strong, nonatomic) IBOutlet UXRStarView *starTwo;
@property (strong, nonatomic) IBOutlet UXRStarView *starThree;
@property (strong, nonatomic) IBOutlet UXRStarView *starFour;
@property (strong, nonatomic) IBOutlet UXRStarView *starFive;
@property (nonatomic,assign) CGFloat starRating;

-(void)layoutStars;

@end
