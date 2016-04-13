//
//  LNCache.m
//  LNCache
//
//  Created by vvusu on 4/13/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import "LNCache.h"
#import "LNCacheManager.h"
#import "User.h"

@implementation LNCache

static User *user;  //内存缓存
#pragma mark - 非用户表
//user
+ (void)cacheUser:(User *)cacheUser {
    if (!cacheUser) {
        return;
    }
    user = cacheUser;
    [LNCacheManager cacheObjectIntoDefaultTable:cacheUser forKey:KIUserCacheKey];
}

+ (User *)cachedUser {
    if (!user) {
        user = [LNCacheManager cachedObjectFromDefaultTableForKey:KIUserCacheKey];
    }
    return user;
}

#pragma mark - 用户表
//联系人分组
+ (void)cachedQQGroupActivity:(NSArray *)cacheQQGroup {
    [LNCacheManager cacheObjectIntoUserTable:cacheQQGroup forKey:@"kQQGroupActivity"];
}

+ (NSArray *)cachedQQGroup {
    return [LNCacheManager cachedObjectFromUserTableForKey:@"kQQGroupActivity"];
}

//QQMessage
+ (void)cachedQQMessageActivity:(NSArray *)cacheQQMessage {
    [LNCacheManager cacheObjectIntoUserTable:cacheQQMessage forKey:@"kQQMessageActivity"];
}

+ (NSArray *)cachedQQMessage {
    return [LNCacheManager cachedObjectFromUserTableForKey:@"kQQMessageActivity"];
}

@end
