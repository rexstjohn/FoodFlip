//
//  NSObject+GATracking.m
//  FoodFlip
//
//  Created by Rex St. John on 1/26/14.
//  Copyright (c) 2014 UX-RX. All rights reserved.
//

#import "NSObject+GATracking.h"
#import <GoogleAnalytics-iOS-SDK/GAIDictionaryBuilder.h>

@implementation NSObject (GATracking)
    
-(void)eventWithCategory:(NSString*)category
              withAction:(NSString*)action
               withLabel:(NSString*)label
                andValue:(NSNumber*)value{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:category     // Event category (required)
                                                          action:action  // Event action (required)
                                                           label:label          // Event label
                                                           value:value] build]];    // Event value
}

-(void)eventWithAction:(NSString*)action
             withLabel:(NSString*)label
              andValue:(NSNumber*)value{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:kUIEVENTCATEGORY     // Event category (required)
                                                          action:action  // Event action (required)
                                                           label:label          // Event label
                                                           value:value] build]];    // Event value
}

@end
