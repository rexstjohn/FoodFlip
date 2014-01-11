//
//  UXRAdTableViewCell.m
//  FMag
//
//  Created by Rex St. John on 12/31/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRAdTableViewCell.h"
#import "UXRGlobals.h"
#import "GADBannerView+SpecificToIdiom.h"

@interface UXRAdTableViewCell()
@property(nonatomic,assign) BOOL setRoot;
@end

@implementation UXRAdTableViewCell

+ (NSString *)cellIdentifier {
    static NSString* _cellIdentifier = @"UXRAdTableViewCell";
    _cellIdentifier = NSStringFromClass([self class]);
    return _cellIdentifier;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.adBanner = [GADBannerView bannerViewForCurrentIdiom];
    self.adBanner.adUnitID = ADMOB_ADVERTISING_KEY;
    
    UIView *adView = [[UIView alloc] initWithFrame:self.frame];
    [adView addSubview:self.adBanner];
    self.adBanner.center = adView.center;
    [self addSubview:adView];
}

+(CGFloat)preferredCellHeight{
    return 100.0f;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if(self.adBanner.rootViewController == nil){
        NSLog(@"Warning, advertisement will not display until you set it's root view controller!");
    }
   
    
}

@end
