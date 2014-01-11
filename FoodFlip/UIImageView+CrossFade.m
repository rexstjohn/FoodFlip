//
//  UIImageView+CrossFade.m
//  FMag
//
//  Created by Rex St. John on 12/31/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UIImageView+CrossFade.h"

@implementation UIImageView (CrossFade)

-(void)crossFadeToImage:(UIImage*)image{
    UIImage * toImage = image;
    [UIView transitionWithView:self
                      duration:1.0
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.image = toImage;
                    } completion:nil];
}

@end
