//
//  PListUtils.h
//  AtourLife
//
//  Created by vvusu on 3/4/16.
//  Copyright © 2016 Anasue. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPListCOConfig @"COConfig"

@interface PListUtils : NSObject

+(id)valueByPListName:(NSString *)pListName withKey:(NSString *)key;

//获取value根据coconfig的plist文件
+(id)valueCOConfigWithKey:(NSString *)key;

//存在默认的Plist文件
+ (void)setValue:(id )value forKey:(NSString *)key;

//根据key从默认的plist文件里读取
+ (id )valueForKey:(NSString *)key;
@end
