//
//  UXRErrorHandler.m
//  FMag
//
//  Created by Rex St. John on 12/24/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRErrorHandler.h"
#import "UXRGlobals.h"

@implementation UXRErrorHandler

#pragma mark - Initializers

- (id) init {
    static BOOL alreadyInitialized = NO;
    if (alreadyInitialized) {
        return self;
    }
    alreadyInitialized = YES;
    
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLocationIssue:) name:LOCATION_ISSUE_NOTIFICATION object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleConnectivityIssue:) name:CONNECTIVITY_ISSUE_NOTIFICATION object:nil];
    }
    return self;
}

+(UXRErrorHandler*) sharedManager; {
    static dispatch_once_t onceQueue;
    static UXRErrorHandler* _sharedInstance;
    dispatch_once(&onceQueue, ^{ _sharedInstance = [[self alloc] init]; });
    return _sharedInstance;
}

#pragma mark - Error Handlers

-(void)handleLocationIssue:(NSNotification*)notification{
    
}

-(void)handleConnectivityIssue:(NSNotification*)notification{
    
}

@end
