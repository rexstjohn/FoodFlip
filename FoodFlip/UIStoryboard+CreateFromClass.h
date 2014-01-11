//
//  UIStoryboard+CreateFromClass.h
//  urbanspin
//
//  Created by Rex St John on 1/13/13.
//  Copyright (c) 2013 Urbanspoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (CreateFromClass)

/*!
 @discussion
 This is a convenience getter for rapidly instanciating classes from the current storyboard.

 WARNINING: This method requires that the view controller's storyboard name be the same as it's class name
 and that the view controller be present in the "current" storyboard"
 and that the storyboard is named following universal app naming conventions
 
 EXAMPLE:
     ViewController name: RestaurantViewController
     ViewController's Storyboard Identifier: RestaurantViewControll
    Storyboard's name: RestaurantDetails~iphone.storyboard
 */
+(UIViewController*)createFromClass:(Class)claz inStoryboardWithUniversalName:(NSString*)storyboarUniversalName;

+(UIViewController*)createFromClass:(Class)claz inStoryboardWithName:(NSString*)storyboard specificToIdiom:(UIUserInterfaceIdiom)targetIdiom;

@end
