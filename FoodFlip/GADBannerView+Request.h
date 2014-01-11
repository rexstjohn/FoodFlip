//
//  GADBannerView+Request.h
//  FMag
//
//  Created by Rex St. John on 1/1/14.
//  Copyright (c) 2014 UX-RX. All rights reserved.
//

#import "GADBannerView.h"

@interface GADBannerView (Request)

-(void)loadRequestInRootViewController:(UIViewController*)vc
                          withDelegate:(id<GADBannerViewDelegate>)delegate;
@end
