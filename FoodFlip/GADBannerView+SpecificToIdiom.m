//
//  GADBannerView+SpecificToIdiom.m
//  FMag
//
//  Created by Rex St. John on 1/1/14.
//  Copyright (c) 2014 UX-RX. All rights reserved.
//

#import "GADBannerView+SpecificToIdiom.h"

@implementation GADBannerView (SpecificToIdiom)

+(GADBannerView*)bannerViewForCurrentIdiom{
    
    GADAdSize adSize = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?kGADAdSizeFullBanner:kGADAdSizeBanner;
    GADBannerView *bannerView = [[GADBannerView alloc] initWithAdSize:adSize];
    return bannerView;
}

@end
