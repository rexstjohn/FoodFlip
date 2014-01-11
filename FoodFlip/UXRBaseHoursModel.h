//
//  UXRBaseHoursModel.h
//  FMag
//
//  Created by Rex St. John on 12/26/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UXRBaseHoursModel

-(NSString*)mondayHoursString;
-(NSString*)tuesdayHoursString;
-(NSString*)thursdayHoursString;
-(NSString*)fridayHoursString;
-(NSString*)saturdayHoursString;
-(NSString*)sundayHoursString;

@end
