//
//  GADBannerView+Request.m
//  FMag
//
//  Created by Rex St. John on 1/1/14.
//  Copyright (c) 2014 UX-RX. All rights reserved.
//

#import "GADBannerView+Request.h"

@implementation GADBannerView (Request)

-(void)loadRequestInRootViewController:(UIViewController*)vc
                          withDelegate:(id<GADBannerViewDelegate>)delegate{
    self.rootViewController = vc;
    self.delegate = delegate;
    GADRequest *adRequest = [[GADRequest alloc] init];
    adRequest.testing = YES;
    [self loadRequest:adRequest];
}
@end
