//
//  NSObject+GATracking.h
//  FoodFlip
//
//  Created by Rex St. John on 1/26/14.
//  Copyright (c) 2014 UX-RX. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUIEVENTCATEGORY @"UIEVENT"
#define kSELECTACTION @"Select"
#define kSEARCHACTION @"Search"

@interface NSObject (GATracking)
    
-(void)eventWithCategory:(NSString*)category
              withAction:(NSString*)action
               withLabel:(NSString*)label
                andValue:(NSNumber*)value;


-(void)eventWithAction:(NSString*)action
               withLabel:(NSString*)label
                andValue:(NSNumber*)value;
@end
