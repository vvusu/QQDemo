//
//  LNUserCacheManager.m
//  QQDemo
//
//  Created by vvusu on 1/11/15.
//  Copyright © 2015 vvusu. All rights reserved.
//

#import "LNUserCacheManager.h"
#import "LNCacheManager.h"
#import "MessageModel.h"

@implementation LNUserCacheManager

#pragma mark - 联系人分组
+ (void)cachedQQGroupActivity:(NSArray *)cacheQQGroup {
    [LNCacheManager cacheObjectIntoUserTable:cacheQQGroup forKey:@"kQQGroupActivity"];
}

+ (NSArray *)cachedQQGroup {
    return [LNCacheManager cachedObjectFromUserTableForKey:@"kQQGroupActivity"];
}

#pragma mark - QQMessage
+ (void)cachedQQMessageActivity:(NSArray *)cacheQQMessage {
    [LNCacheManager cacheObjectIntoUserTable:cacheQQMessage forKey:@"kQQMessageActivity"];
}

+ (NSArray *)cachedQQMessage {
    return [LNCacheManager cachedObjectFromUserTableForKey:@"kQQMessageActivity"];
}

@end
