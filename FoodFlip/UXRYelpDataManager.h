//
//  UXRYelpDataManager.h
//  FMag
//
//  Created by Rex St. John on 12/20/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRSearchDataProvider.h"
#import "UXRLocationDataManager.h"

@interface UXRYelpDataManager : NSObject <UXRSearchDataProvider,UXRLocationDataManagerDelegate>

+(UXRYelpDataManager*) sharedManager;
-(void)triggerUpdate:(NSNotification*)notification;
-(void)onResultsDidUpdate;
-(void)onUpdateFailed;

@end
