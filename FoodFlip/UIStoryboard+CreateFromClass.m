//
//  UIStoryboard+CurrentStoryboard.m
//  urbanspin
//
//  Created by Rex St John on 1/13/13.
//  Copyright (c) 2013 Urbanspoon. All rights reserved.
//

#import "UIStoryboard+CreateFromClass.h"
#import "UIStoryboard+storyboardWithUniversalName.h"

#define kHomeStoryboardName @"tacos"

@implementation UIStoryboard (CreateFromClass)
 
+(UIViewController*)createFromClass:(Class)claz inStoryboardWithUniversalName:(NSString*)storyboarUniversalName{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithUniversalName:storyboarUniversalName
                                                                               bundle:[NSBundle mainBundle]];
    UIViewController *targetVc = [storyboard instantiateViewControllerWithIdentifier:[claz description]];
    return targetVc;
}

+(UIStoryboard*)currentStoryboard{
    UIStoryboard *storyboard;
    storyboard = [UIStoryboard storyboardWithUniversalName:kHomeStoryboardName
                                                    bundle:nil];
    return storyboard;
}

+(UIViewController*)createFromClass:(Class)claz inStoryboardWithName:(NSString*)storyboardName specificToIdiom:(UIUserInterfaceIdiom)targetIdiom{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName andInterfaceIdiom:targetIdiom bundle:nil];
    UIViewController *targetVc = [storyboard instantiateViewControllerWithIdentifier:[claz description]];
    return targetVc;
}

@end
