//
//  UIImage+ImageCrop.h
//  QQDemo
//
//  Created by vvusu on 3/11/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageCrop)
- (UIImage *)ln_cropEqualScaleImageToSize:(CGSize)size;

- (UIImage *)ln_addCornerRadius:(CGFloat)cornerRadius;

@end
