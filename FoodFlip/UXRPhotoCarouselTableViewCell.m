//
//  UXRPhotoCarouselTableViewCell.m
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRPhotoCarouselTableViewCell.h"

@implementation UXRPhotoCarouselTableViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    [self.photoCarousel setFrame:self.frame];
}

-(void)prepareForReuse{
    [super prepareForReuse];
    [self.networkOperation cancel];
    self.networkOperation = nil;
}

#pragma mark - Superclass Overrides

+ (NSString *)cellIdentifier {
    static NSString* _cellIdentifier = @"UXRPhotoCarouselTableViewCell";
    _cellIdentifier = NSStringFromClass([self class]);
    return _cellIdentifier;
}

+(CGFloat)preferredCellHeight{
    return 250.0f;
}

@end
