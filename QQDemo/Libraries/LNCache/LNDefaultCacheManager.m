//
//  LNDefaultCacheManager.m
//  QQDemo
//
//  Created by vvusu on 1/11/15.
//  Copyright © 2015 vvusu. All rights reserved.
//

#import "LNDefaultCacheManager.h"
#import "LNCacheManager.h"

static NSString *const kUserKeyForDefaultCache = @"kUserKeyForDefaultCache";

@implementation LNDefaultCacheManager

+ (void)cacheUser:(id)cacheUser {
    if (!cacheUser) {
        return;
    }
    [LNCacheManager cacheObjectIntoDefaultTable:cacheUser forKey:kUserKeyForDefaultCache];
}

+ (id)cachedUser {
    id user = [LNCacheManager cachedObjectFromDefaultTableForKey:kUserKeyForDefaultCache];
    return user;
}

@end
