//
//  UXRStarView.m
//  FMag
//
//  Created by Rex St. John on 12/27/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRStarView.h"

@implementation UXRStarView

+ (NSString *)viewIdentifier {
    static NSString* _viewIdentifier = @"UXRStarView";
    _viewIdentifier = NSStringFromClass([self class]);
    return _viewIdentifier;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setStarState:(UXRStarViewState)starState{
    
    if(starState == UXRHalfStarState){
        [self.imageView setImage:[UIImage imageNamed:@"half_star"]];
    } else if(starState == UXRFullStarState){
        [self.imageView setImage:[UIImage imageNamed:@"full_star"]];
    } else {
        self.imageView.image = nil;
    }
    [self.imageView setNeedsLayout];
    
    _starState = starState;
}

@end
