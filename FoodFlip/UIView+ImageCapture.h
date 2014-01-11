//
//  UIView+ImageCapture.h
//  urbanspin
//
//  Created by Rex St John on 2/6/13.
//  Copyright (c) 2013 Urbanspoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ImageCapture)

-(UIImage*)captureViewImageAndSaveToDisk:(BOOL)saveToDisk;

@end
