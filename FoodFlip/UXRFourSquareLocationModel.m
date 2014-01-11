//
//  UXRFourSquareLocationModel.m
//  FMag
//
//  Created by Rex St. John on 12/20/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRFourSquareLocationModel.h"

@implementation UXRFourSquareLocationModel


-(BOOL)isModelValid{
    BOOL isValid = YES;
    
    isValid = self.city != nil;
    isValid = self.country != nil;
    isValid = self.lat != nil;
    isValid = self.lng != nil; 
    
    return isValid;
}

@end
