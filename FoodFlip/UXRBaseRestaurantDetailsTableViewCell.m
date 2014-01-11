//
//  UXRBaseRestaurantDetailsTableViewCell.m
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRBaseRestaurantDetailsTableViewCell.h"

@implementation UXRBaseRestaurantDetailsTableViewCell

+(CGFloat)preferredCellHeight{
    [NSException raise:NSInternalInconsistencyException format:@"WARNING: YOU MUST OVERRIDE THIS GETTER IN YOUR CUSTOM CELL .M FILE"];
    return 0.0f;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

@end
