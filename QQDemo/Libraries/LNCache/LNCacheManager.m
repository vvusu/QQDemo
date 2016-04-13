//
//  LNCacheManager.m
//  QQDemo
//
//  Created by vvusu on 1/10/15.
//  Copyright © 2015 vvusu. All rights reserved.
//

#import "LNCacheManager.h"
#import "LNKeyValueStore.h"
#import "User.h"

@implementation LNCacheManager

NSString *const KIUserCacheKey = @"kIUserActivity";
static NSString *const kCachedDBName = @"cache.db";
static NSString *const kDataBaseDefaultTableName = @"table_kRDefault";

static LNKeyValueStore *instance;
static NSString *kCachedUserTableName;
static NSString *kCachedDefaultTableName;

+ (LNKeyValueStore *)sharedUserStore {
    User *user = [self cachedObjectFromDefaultTableForKey:KIUserCacheKey];
    NSString *un = user.uid;
    if (un.length == 0) {
        return nil;
    }
    NSString *newTableName = [NSString stringWithFormat:@"table_%@",un];
    if (!instance) {
        instance = [[LNKeyValueStore alloc] initDBWithName:kCachedDBName];
    }
    if (![kCachedUserTableName isEqualToString:newTableName]) {
        kCachedUserTableName = newTableName;
        [instance createTableWithName:kCachedUserTableName];
    }
    return instance;
}

+ (LNKeyValueStore *)sharedDefaultStore {
    if (!instance) {
        instance = [[LNKeyValueStore alloc] initDBWithName:kCachedDBName];
    }
    if (!kCachedDefaultTableName) {
        kCachedDefaultTableName = kDataBaseDefaultTableName;
        [instance createTableWithName:kCachedDefaultTableName];
    }
    return instance;
}

#pragma mark - 基础
+ (void)cacheObject:(id)object forKey:(NSString *)key intoTable:(NSString *)tableName valueStore:(LNKeyValueStore *)valueStore {
    if (nil == object) {
        [self deleteObjectForKey:key fromTable:tableName valueStore:valueStore];
        return;
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    if (data.length) {
        [valueStore putDataObject:data withId:key intoTable:tableName];
    }
}

+ (id)cachedObjectForKey:(NSString *)key fromTable:(NSString *)tableName valueStore:(LNKeyValueStore *)valueStore {
    NSData *data = [valueStore getDataObjectById:key fromTable:tableName];
    if (data) {
        id result = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return result;
    }
    return nil;
}

+ (void)deleteObjectForKey:(NSString *)key fromTable:(NSString *)tableName valueStore:(LNKeyValueStore *)valueStore {
    [valueStore deleteObjectById:key fromTable:tableName];
}

#pragma mark - 用户表
+ (void)cacheObjectIntoUserTable:(id)object forKey:(NSString *)key {
    LNKeyValueStore *valueStore = [self sharedUserStore];
    [self cacheObject:object forKey:key intoTable:kCachedUserTableName valueStore:valueStore];
}

+ (id)cachedObjectFromUserTableForKey:(NSString *)key {
    LNKeyValueStore *valueStore = [self sharedUserStore];
    return [self cachedObjectForKey:key fromTable:kCachedUserTableName valueStore:valueStore];
}

+ (void)deleteObjectFromUserTableForKey:(NSString *)key {
    LNKeyValueStore *valueStore = [self sharedUserStore];
    [self deleteObjectForKey:key fromTable:kCachedUserTableName valueStore:valueStore];
}

#pragma mark - 默认表（非用户）
+ (void)cacheObjectIntoDefaultTable:(id)object forKey:(NSString *)key {
    LNKeyValueStore *valueStore = [self sharedDefaultStore];
    [self cacheObject:object forKey:key intoTable:kCachedDefaultTableName valueStore:valueStore];
}

+ (id)cachedObjectFromDefaultTableForKey:(NSString *)key {
    LNKeyValueStore *valueStore = [self sharedDefaultStore];
    return [self cachedObjectForKey:key fromTable:kCachedDefaultTableName valueStore:valueStore];
}

+ (void)deleteObjectFromDefaultTableForKey:(NSString *)key {
    LNKeyValueStore *valueStore = [self sharedDefaultStore];
    [self deleteObjectForKey:key fromTable:kCachedDefaultTableName valueStore:valueStore];
}

@end
