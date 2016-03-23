//
//  PListUtils.m
//  AtourLife
//
//  Created by vvusu on 3/4/16.
//  Copyright © 2016 Anasue. All rights reserved.
//

#import "PListUtils.h"

#define Defaults [NSUserDefaults standardUserDefaults]
@implementation PListUtils
+ (id)valueByPListName:(NSString *)pListName withKey:(NSString *)key{
    static NSMutableDictionary *data = nil;
    if (!data) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:pListName ofType:@"plist"];
        data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    }
    return [data objectForKey:key];
}

//获取value根据coconfig的plist文件
+ (id)valueCOConfigWithKey:(NSString *)key{
    return [self valueByPListName:kPListCOConfig withKey:key];
}

+ (void)setCOConfigValue:(id)value forKey:(NSString *)key {
    static NSMutableDictionary *data = nil;
    if (!data) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:kPListCOConfig ofType:@"plist"];
        data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    }
    [data setObject:value forKey:key];
}

//存在默认的Plist文件
+ (void)setValue:(id )value forKey:(NSString *)key{
    [Defaults setObject:value forKey:key];
    [Defaults synchronize];
}
//根据key从默认的plist文件里读取
+ (id )valueForKey:(NSString *)key{
    return [Defaults valueForKey:key];
}

@end
