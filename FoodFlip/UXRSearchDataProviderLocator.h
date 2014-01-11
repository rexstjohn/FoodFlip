//
//  UXRSearchDataProviderLocator.h
//  FMag
//
//  Created by Rex St. John on 1/2/14.
//  Copyright (c) 2014 UX-RX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UXRSearchDataProvider.h"

@interface UXRSearchDataProviderLocator : NSObject

+(UXRSearchDataProviderLocator*) sharedManager;
-(void)setProvider:(id<UXRSearchDataProvider>)provider;
@property(nonatomic,assign) id<UXRSearchDataProvider> globalProvider;

@end
