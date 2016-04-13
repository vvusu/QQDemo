//
//  PointUtils.h
//  QQDemo
//
//  Created by vvusu on 3/19/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PointUtils : NSObject
//获取view上的中心点
+ (CGPoint)getGlobalCenterPositionOf:(UIView *)view;

//获取view上的点
+ (CGPoint)getGlobalPositionOf:(UIView *)view;

@end
