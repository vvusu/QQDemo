//
//  LNQQBombButton.h
//  QQDemo
//
//  Created by vvusu on 3/11/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNQQBombButton : UIButton
//大圆脱离小圆的最大距离
@property (nonatomic, assign) CGFloat maxDistance;
//小圆
@property (nonatomic, strong) UIView *samllCircleView;
//按钮消失的动画图片组
@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, weak) UIView *rootView;
@end
