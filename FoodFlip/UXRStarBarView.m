//
//  UXRStarBarView.m
//  FMag
//
//  Created by Rex St. John on 12/27/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRStarBarView.h"
#import <math.h>

@interface UXRStarBarView()
@property(nonatomic,strong) NSArray *stars;
@end

@implementation UXRStarBarView

+ (NSString *)viewIdentifier {
    static NSString* _viewIdentifier = @"UXRStarBarView";
    _viewIdentifier = NSStringFromClass([self class]);
    return _viewIdentifier;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    
    self.starOne = [[UXRStarView alloc] initWithFrame:self.starOne.frame];
    self.starTwo = [[UXRStarView alloc] initWithFrame:self.starTwo.frame];
    self.starThree = [[UXRStarView alloc] initWithFrame:self.starThree.frame];
    self.starFour = [[UXRStarView alloc] initWithFrame:self.starFour.frame];
    self.starFive = [[UXRStarView alloc] initWithFrame:self.starFive.frame];
    
    self.stars = @[self.starOne,self.starTwo,self.starThree,self.starFour,self.starFive];
    
    for(UXRStarView *star in self.stars){
        [self addSubview:star];
    }
}

-(void)setStarRating:(CGFloat)starRating{
    
    _starRating = starRating;

    int i = 0;
    CGFloat rating = _starRating;
    
    while(i < self.stars.count && rating > 0){
        UXRStarView *starView = self.stars[i];
        
        if(rating >= 1){
            [starView setStarState:UXRFullStarState];
            rating -= 1;
        } else if (rating == .5) {
            [starView setStarState:UXRHalfStarState];
            rating -= 0.5f;
        } else {
            [starView setStarState:UXRNoStarsState];
        }
        i++;
    }
}


@end
