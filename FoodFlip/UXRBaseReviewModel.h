//
//  UXRBaseReviewModel.h
//  FMag
//
//  Created by Rex St. John on 12/23/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UXRBaseUserModel.h"

@protocol UXRBaseReviewModel
-(NSString*)reviewBodyText;
-(NSString*)reviewTitleText;
-(id<UXRBaseUserModel>)reviewUserAuthor;
@end
