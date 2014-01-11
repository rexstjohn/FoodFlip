//
//  UXRRestaurantHeaderView.m
//  FMag
//
//  Created by Rex St. John on 12/18/13.
//  Copyright (c) 2013 UX-RX. All rights reserved.
//

#import "UXRRestaurantHeaderView.h"
#import "UXRGlobals.h"
#import "UXRSearchDataReciever.h"
#import "UXRSearchDataProviderLocator.h"

@implementation UXRRestaurantHeaderView

+ (NSString *)viewIdentifier {
    static NSString* _viewIdentifier = @"UXRRestaurantHeaderView";
    _viewIdentifier = NSStringFromClass([self class]);
    return _viewIdentifier;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    //self.backgroundColor = [UIColor clearColor];
    self.searchBar.text = @" ";
    self.searchBar.placeholder = @"Search for food here e.g. pizza";
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(restaurantDataUpdateDidFailWithError:)
                                                 name:RESTAURANT_DATA_UPDATE_FAILURE_NOTIFICATION
                                               object:nil];
}

#pragma mark - Restaurant data results delegate

-(void)restaurantDataUpdateDidFailWithError:(NSNotification*)notification{
    // Replace the query string with whatever was last being used as the query string.
    self.searchBar.text = [[[UXRSearchDataProviderLocator sharedManager] globalProvider] getQueryString];
}

#pragma mark - UISearchBarDelegate

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.text = @" ";
    [searchBar becomeFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length < 1) {
        searchBar.text = @" ";
    }
}

- (BOOL)searchBar:(UISearchBar *)searchBar
shouldChangeTextInRange:(NSRange)range
  replacementText:(NSString *)text
{
    BOOL isPreviousTextDummyString = [searchBar.text isEqualToString:@" "];
    BOOL isNewTextDummyString = [text isEqualToString:@" "];
    if (isPreviousTextDummyString && !isNewTextDummyString && text.length > 0) {
        searchBar.text = @"";
    }
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    
    NSString *textToSearch = @"food";
    
    if([searchBar.text isEqualToString:@" "]){
        textToSearch = @"food";
    } else {
        textToSearch = self.searchBar.text;
    }
    
    NSDictionary *dictionary = @{SEARCH_BAR_USER_INFO_QUERY_KEY:textToSearch};
    [[NSNotificationCenter defaultCenter] postNotificationName:SEARCH_BAR_DID_SEARCH_NOTIFICATION object:nil userInfo:dictionary];
}

@end
