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

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        CGFloat padding = (frame.size.width * .2) / 5;
        CGFloat starWidth = (frame.size.width - (padding * 5)) / 5;
        CGRect starRect = CGRectMake(0, 0, starWidth, starWidth);
        
        self.starOne = [[UXRStarView alloc] initWithFrame:starRect];
        self.starTwo = [[UXRStarView alloc] initWithFrame:starRect];
        self.starThree = [[UXRStarView alloc] initWithFrame:starRect];
        self.starFour = [[UXRStarView alloc] initWithFrame:starRect];
        self.starFive = [[UXRStarView alloc] initWithFrame:starRect];
        
        self.stars = @[self.starOne,self.starTwo,self.starThree,self.starFour,self.starFive];
        
        int i = 5;
        for(UXRStarView *star in self.stars){
            CGFloat leftOffset = (i * starWidth) + (i * padding);
            CGRect starRectOffset = CGRectMake(leftOffset - frame.size.width, 0, starWidth, starWidth);
            [star setFrame:starRectOffset];
            [self addSubview:star];
            i ++;
        }
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
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
