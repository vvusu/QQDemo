//
//  LNDefaultCacheManager.h
//  QQDemo
//
//  Created by vvusu on 1/11/15.
//  Copyright © 2015 vvusu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNDefaultCacheManager : NSObject

#pragma mark - User
+ (void)cacheUser:(id)cacheUser;
+ (id)cachedUser;

#pragma mark - Other

@end
