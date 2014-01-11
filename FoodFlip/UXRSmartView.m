//
//  USPSmartView.m
//  urbanspin
//
//  Created by Rex St John on 4/15/13.
//  Copyright (c) 2013 Urbanspoon. All rights reserved.
//

#import "UXRSmartView.h"

@implementation UXRSmartView

- (id)initWithFrame:(CGRect)frame
{
    id rootView = [[self class] viewSizedForDevice];
    [rootView setFrame:frame];
    self = rootView;
     
    if(self){
        // 
    }
    
    return self;
}

+ (id) viewSizedForDevice; {
    UINib* nib = [self nib];
    NSArray * nibObjects = [nib instantiateWithOwner:self options:nil];
    NSAssert2(([nibObjects count] > 0) &&
              [[nibObjects objectAtIndex:0] isKindOfClass:[self class]],
              @"Nib '%@' does not appear to contain a value %@",
              [self nibName], NSStringFromClass([self class]));
    id rootView = nibObjects[0];
    return rootView;
}

#pragma  mark - Smart Nib View

+(UINib*)nib; {
    NSBundle * classBundle = [NSBundle bundleForClass:[self class]];
    UINib * nib = [UINib nibWithNibName:[self nibName] bundle:classBundle];
    return nib;
}

+ (NSString *)nibName {
    return [self viewIdentifier];
}

+ (NSString *)viewIdentifier {
    [NSException raise:NSInternalInconsistencyException format:@"WARNING: YOU MUST OVERRIDE THIS GETTER IN YOUR CUSTOM VIEW .M FILE"];
    static NSString* _viewIdentifier = nil;
    _viewIdentifier = NSStringFromClass([self class]);
    return _viewIdentifier;
}
@end
