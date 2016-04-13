//
//  User.m
//  LNCache
//
//  Created by vvusu on 4/13/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import "User.h"

@implementation User

+ (instancetype)userWithDict:(NSDictionary *)dic {
    User *user = [[self alloc]init];
    user.uid = dic[@"uid"];
    return user;
}

/**
 *  将对象写入文件的时候调用
 *  在这个方法中写清楚：要存储哪些对象的哪些属性，以及怎样存储属性
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.uid forKey:@"uid"];
}

/**
 *  当从文件中解析出一个对象的时候调用
 *  在这个方法中写清楚：怎么解析文件中的数据
 */
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}

@end
