//
//  AppUtils.h
//  AtourLife
//
//  Created by vvusu on 3/12/16.
//  Copyright © 2016 Anasue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppUtils : NSObject
//获取应用名
+ (NSString *)appName;

//获取版本号
+ (NSString *)appVersionName;

//获取系统Version
+ (double)osVersion;

//评论url
+ (NSString *)commonUrl:(NSString *)appId;

//appurl
+ (NSString *)appUrl:(NSString *)appId;

//本地IP地址
+ (NSString *)localIPAddress;

@end
