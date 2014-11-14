//
//  UIImage+Cropping.h
//  UXRX
//
//  Created by Rex St John on 3/24/13.
//  Copyright (c) 2013 UXRX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Cropping)

-(UIImage*)croppedToRect:(CGRect)cropRect;
-(UIImage*)croppedImageInScrollView:(UIScrollView*)scrollView;

@end
