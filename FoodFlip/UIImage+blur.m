//
//  UIImage+blur.m
//  urbanspin
//
//  Created by JASON CROSS on 7/11/13.
//  Copyright (c) 2013 Urbanspoon. All rights reserved.
//

#import "UIImage+blur.h"


@implementation UIImage (blur)


- (UIImage*) blurImageWithBlurLevel:(CGFloat)blur {
    
    // the raw un-modified image
    CIImage * inputImage = [CIImage imageWithCGImage:self.CGImage];
    
    // filter : blur
    CIFilter * blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setValue:inputImage
                  forKey:kCIInputImageKey];
    [blurFilter setValue:@(blur)
                  forKey:@"inputRadius"];
    
    // translate CIImage -> CGImageRef -> UIImage
    CIImage * result = blurFilter.outputImage;
    CIContext * context = [CIContext contextWithOptions:nil];
    CGImageRef outImage = [context createCGImage:result
                                        fromRect:[inputImage extent]];
    UIImage * value = [UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    
    return value;
}


@end
