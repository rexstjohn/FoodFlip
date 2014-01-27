//
//  UXRRestaurantHeaderTableViewCell.m
//  FMag
//
//  Created by Rex St. John on 12/22/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRRestaurantPrimaryTableViewCell.h"
#import "UXRGlobals.h"
#import "UXRSearchDataProvider.h"
#import "UXRFourSquareDataManager.h"
#import "UIView+AddBorderWithColor.h"
#import "UIView+SimpleSizing.h"

@interface UXRRestaurantPrimaryTableViewCell()
@property(nonatomic,strong) NSArray *locations;
@property(nonatomic,strong) NSString *preEditingText;
@end

@implementation UXRRestaurantPrimaryTableViewCell

+ (NSString *)cellIdentifier {
    static NSString* _cellIdentifier = @"UXRRestaurantPrimaryTableViewCell";
    _cellIdentifier = NSStringFromClass([self class]);
    return _cellIdentifier;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    // Autocompletions
    NSString *file = [[NSBundle mainBundle] pathForResource:@"Neighborhoods" ofType:@"txt"];
    NSData* data = [NSData dataWithContentsOfFile:file];
    NSString* neighborhoodsString = [[NSString alloc] initWithBytes:[data bytes]
                                                             length:[data length]
                                                           encoding:NSUTF8StringEncoding];
    NSString* delimiter = @"\n";
    NSArray* neighborhoods = [neighborhoodsString componentsSeparatedByString:delimiter];
    self.locationTextField.autocompleteDataSource=self;
    self.locations = neighborhoods;
    self.locationTextField.autocompleteLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
    
    // Trap the text.
    self.preEditingText = self.locationTextField.text;
    
    // Stars
    CGFloat starWidth = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?200:80;
    self.starBar = [[UXRStarBarView alloc] initWithFrame:CGRectMake(20, starWidth, 130, starWidth/5)];
    [self addSubview:self.starBar];
}

#pragma mark - Superclass Overrides

+(CGFloat)preferredCellHeight{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if(UIDeviceOrientationIsLandscape(orientation) == YES){
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenHeight = screenRect.size.width;
        return screenHeight;
    } else {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenHeight = screenRect.size.height;
        return screenHeight;
    }
}

#pragma mark - Actions

-(IBAction)didTapMapButton:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:MAP_BUTTON_REQUESTED_OPEN_NOTIFICATION object:sender];
}

-(IBAction)didTapFilterButton:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:FILTER_BUTTON_REQUESTED_OPEN_NOTIFICATION object:sender];
}

#pragma mark - UITextFieldDelegate


-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    // Hack to prevent table view from auto scrolling.
    self.locationTextField.textAlignment = NSTextAlignmentLeft;
    self.locationTextField.text = @" ";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    self.locationTextField.textAlignment = NSTextAlignmentCenter;
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    // Control for what happens when we have a @" " text string.
    self.locationTextField.textAlignment = NSTextAlignmentCenter;
    if(self.locationTextField.text.length == 0 || [self.locationTextField.text isEqualToString:@" "]){
        self.locationTextField.text = self.preEditingText;
    }
    
    // Capitalize things properly.
    NSString *preAdjustmentSearchString = self.locationTextField.text;
    NSString *adjustedSearchString = [self.locationTextField.text capitalizedString];
    self.locationTextField.text = adjustedSearchString;
    
    // Hey everyone, a search happened.
    NSDictionary *userInfo = @{SEARCH_BAR_USER_INFO_QUERY_KEY:preAdjustmentSearchString};
    [[NSNotificationCenter defaultCenter] postNotificationName:LOCATION_SEARCH_DID_END_EDITING_NOTIFICATION object:nil userInfo:userInfo];
}

#pragma mark - HTAutoCompleteTextField

- (NSString *)textField:(HTAutocompleteTextField *)textField
    completionForPrefix:(NSString *)prefix
             ignoreCase:(BOOL)ignoreCase{
    
    // remove the @" " injected to keep the search button available.
    if(prefix.length > 0){
        NSString *firstCharacter = [prefix substringWithRange:NSMakeRange(0, 1)];
        if ([firstCharacter isEqualToString:@" "] == YES) {
            prefix = [prefix substringWithRange:NSMakeRange(1, prefix.length - 1)];
        }
    }
    
    // Perform autocompletions.
    NSString *stringToLookFor;
    if (ignoreCase)
    {
        stringToLookFor = [prefix lowercaseString];
    }
    else
    {
        stringToLookFor = prefix;
    }
    
    for (NSString *stringFromReference in self.locations)
    {
        NSString *stringToCompare;
        if (ignoreCase)
        {
            stringToCompare = [stringFromReference lowercaseString];
        }
        else
        {
            stringToCompare = stringFromReference;
        }
        
        if ([stringToCompare hasPrefix:stringToLookFor])
        {
            return [stringFromReference stringByReplacingCharactersInRange:[stringToCompare rangeOfString:stringToLookFor]
                                                                withString:@""];
        }
        
    }
    return @" ";
}


#pragma mark -

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.locationTextField addBottomBorderToRect:rect currentContext:ctx borderColor:[UIColor whiteColor] borderWidth:2.0f];
    [self.starBar setFrameX:20];
    [self.starBar setFrameY:rect.size.height - self.starBar.sizeHeight - 30 - (self.starBar.frame.size.height / 2)];
}
@end
