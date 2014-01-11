//
//  UXRRestaurantHoursTableViewCell+Binding.m
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRRestaurantHoursTableViewCell+Binding.h"
#import "UXRLabel.h"
#import "UXRFourSquareRestaurantModel.h"
#import "UXRFourSquareTimeFramesModel.h"
#import "UXRFourSquareOpenTime.h"
#import "UXRFourSquareHoursModel.h"
#import <CoreText/CoreText.h>

@implementation UXRRestaurantHoursTableViewCell (Binding)

-(void)bindToRestaurantModel:(id<UXRBaseRestaurantModel>)model{
    UXRFourSquareRestaurantModel *restaurantModel = (UXRFourSquareRestaurantModel*)model;
    UXRFourSquareHoursModel *hours = restaurantModel.hours;
    
    if(hours.timeframes.count == 0){
        self.hoursColumnOneLabel.text = @"No hours available";
    }
    
    NSIndexSet *indexes;
    if(hours.timeframes.count > 0){
        int end = (hours.timeframes.count > 1)?2:1;
        indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, end)];
        NSArray *firstHours = [hours.timeframes objectsAtIndexes:indexes];
        [self addHours:firstHours toLabel:self.hoursColumnOneLabel];
    }

    if(hours.timeframes.count > 2){
        int end = (hours.timeframes.count > 3)?2:1;
        indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, end)];
        NSArray *secondHours = [hours.timeframes objectsAtIndexes:indexes];
        [self addHours:secondHours toLabel:self.hoursColumnTwoLabel];
    }
}

-(void)addHours:(NSArray*)hours toLabel:(UXRLabel*)label{
    
    // CoreText dynamic formatting.
    UIFontDescriptor* fontDescriptor = [UIFontDescriptor
                                        preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
    UIFontDescriptor* boldFontDescriptor = [fontDescriptor
                                            fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    UIFont* boldFont =  [UIFont fontWithDescriptor:boldFontDescriptor size: 17.0];
    NSDictionary* boldAttributes = @{ NSFontAttributeName : boldFont };
    
    // Display hours and ranges.
    NSMutableAttributedString *openText = [[NSMutableAttributedString alloc] init];
    for(UXRFourSquareTimeFramesModel *timeFrame in hours){
        NSAttributedString *newAttString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",timeFrame.days] attributes:nil];
        [openText appendAttributedString:newAttString];
        
        // Bold the title ranges.
        NSRange boldRange = [[openText mutableString] rangeOfString:timeFrame.days];
        [openText addAttributes:boldAttributes range:boldRange];
        
        for(UXRFourSquareOpenTime *openTime in timeFrame.open){
            NSAttributedString *openTimeAtt = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",openTime.renderedTime] attributes:nil];
            [openText appendAttributedString:openTimeAtt];
        }
        // Insert one more newline
        NSAttributedString *newLineAtt = [[NSAttributedString alloc] initWithString:@"\n" attributes:nil];
        [openText appendAttributedString:newLineAtt];
    }
    
    label.attributedText = openText;
}

@end
