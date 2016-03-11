//
//  LNUserCacheManager.h
//  QQDemo
//
//  Created by vvusu on 1/11/15.
//  Copyright © 2015 vvusu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNUserCacheManager : NSObject

#pragma mark - 用户联系人分组信息
+ (void)cachedQQGroupActivity:(NSArray *)cacheQQGroup;
+ (NSArray *)cachedQQGroup;

#pragma mark - 用户Message信息
+ (void)cachedQQMessageActivity:(NSArray *)cacheQQMessage;
+ (NSArray *)cachedQQMessage;

@end
