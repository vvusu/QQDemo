//
//  User.h
//  LNCache
//
//  Created by vvusu on 4/13/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSCoding>
@property (nonatomic, copy) NSString *uid;
+ (instancetype)userWithDict:(NSDictionary *)dic;

@end
