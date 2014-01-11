//
//  UXRSmartTableViewCell.h
//  uxrx
//
//  Smart table view cell take from iOS Recipies. Provides easy access to fetching cell identifiers using the class name
//  and looks after providing it's own dequeuing automatically on demand.
//
//  Created by Rex St John on 1/17/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UXRSmartTableViewCell : UITableViewCell

@property (strong, nonatomic) UIColor *customContentBackgroundColor UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIColor *customContentSpacerColor UI_APPEARANCE_SELECTOR;
@property(nonatomic,assign) CGFloat customTableCellContentSpacing UI_APPEARANCE_SELECTOR;

+(NSString*)cellIdentifier;
+(id)cellForTableView:(UITableView*)tableView fromNib:(UINib*)nib;
+(id)cellForTableView:(UITableView*)tableView;
+(UINib*)nib;
-(CGRect)tableCellContentRect;

// Dynamic sizing methods.
+ (float)heightForString:(NSString *)contentString inTableView:(UITableView *)tableView;

@end
