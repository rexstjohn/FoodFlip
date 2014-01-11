//
//  UXRStarView.h
//  FMag
//
//  Created by Rex St. John on 12/27/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRSmartView.h"

typedef enum{
    UXRNoStarsState=0,
    UXRHalfStarState,
    UXRFullStarState
}UXRStarViewState;

@interface UXRStarView : UXRSmartView
@property(nonatomic,assign) UXRStarViewState starState;
@property(nonatomic,strong) IBOutlet UIImageView *imageView;
@end
