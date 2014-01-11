//
//  UXRSearchDataProviderLocator.m
//  FMag
//
//  Created by Rex St. John on 1/2/14.
//  Copyright (c) 2014 UX-RX. All rights reserved.
//

#import "UXRSearchDataProviderLocator.h"
#import "UXRSearchDataProvider.h"

@interface UXRSearchDataProviderLocator()
@end

@implementation UXRSearchDataProviderLocator

- (id) init {
    static BOOL alreadyInitialized = NO;
    if (alreadyInitialized) {
        return self;
    }
    alreadyInitialized = YES;
    
    self = [super init];
    if (self) {
    }
    return self;
}

+(UXRSearchDataProviderLocator*) sharedManager; {
    static dispatch_once_t onceQueue;
    static UXRSearchDataProviderLocator * _sharedInstance;
    dispatch_once(&onceQueue, ^{ _sharedInstance = [[self alloc] init]; });
    return _sharedInstance;
}

-(void)setProvider:(id<UXRSearchDataProvider>)provider{
    self.globalProvider = provider;
}

@end
