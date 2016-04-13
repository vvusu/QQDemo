//
//  LNCacheManager.h
//  QQDemo
//
//  Created by vvusu on 1/10/15.
//  Copyright © 2015 vvusu. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const KIUserCacheKey;

@interface LNCacheManager : NSObject
// 用户表
+ (void)cacheObjectIntoUserTable:(id)object forKey:(NSString *)key;
+ (id)cachedObjectFromUserTableForKey:(NSString *)key;
+ (void)deleteObjectFromUserTableForKey:(NSString *)key;

// 默认表
+ (void)cacheObjectIntoDefaultTable:(id)object forKey:(NSString *)key;
+ (id)cachedObjectFromDefaultTableForKey:(NSString *)key;
+ (void)deleteObjectFromDefaultTableForKey:(NSString *)key;

@end
