//
//  LNCache.h
//  LNCache
//
//  Created by vvusu on 4/13/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@interface LNCache : NSObject

#pragma mark - 非用户表
//user
+ (void)cacheUser:(User *)cacheUser;
+ (User *)cachedUser;

#pragma mark - 用户表
//用户联系人分组信息
+ (void)cachedQQGroupActivity:(NSArray *)cacheQQGroup;
+ (NSArray *)cachedQQGroup;

//用户Message信息
+ (void)cachedQQMessageActivity:(NSArray *)cacheQQMessage;
+ (NSArray *)cachedQQMessage;

@end
