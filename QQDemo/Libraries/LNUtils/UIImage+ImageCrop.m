//
//  UIImage+ImageCrop.m
//  QQDemo
//
//  Created by vvusu on 3/11/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import "UIImage+ImageCrop.h"

@implementation UIImage (ImageCrop)
// 等比缩放
- (UIImage *)cropEqualScaleImageToSize:(CGSize)size {
    CGFloat scale =  [UIScreen mainScreen].scale;
    
    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
    
    CGSize aspectFitSize = CGSizeZero;
    if (self.size.width != 0 && self.size.height != 0) {
        CGFloat rateWidth = size.width / self.size.width;
        CGFloat rateHeight = size.height / self.size.height;
        
        CGFloat rate = MIN(rateHeight, rateWidth);
        aspectFitSize = CGSizeMake(self.size.width * rate, self.size.height * rate);
    }
    
    [self drawInRect:CGRectMake(0, 0, aspectFitSize.width, aspectFitSize.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

// 非等比缩放
- (UIImage *)ln_cropEqualScaleImageToSize:(CGSize)size {
    CGFloat scale =  [UIScreen mainScreen].scale;
    
    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)ln_addCornerRadius:(CGFloat)cornerRadius {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, scale);
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                    cornerRadius:cornerRadius];
    CGContextAddPath(c, path.CGPath);
    
    CGContextClip(c);
    [self drawInRect:rect];
    CGContextDrawPath(c, kCGPathFillStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
